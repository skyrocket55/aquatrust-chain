const express = require('express');
const fs = require('fs');
const path = require('path');
const { Wallets, Gateway } = require('fabric-network');

const app = express();
const port = 3000;

const testNetworkRoot = path.resolve(require('os').homedir(), 'hyperledger-fabric/fabric-samples/test-network');

const gateway = new Gateway();
let wallet;

async function init() {
    wallet = await Wallets.newFileSystemWallet('./wallet');
}

init();

app.use(express.json());

async function getContract(identityLabel) {
    const orgName = identityLabel.split('@')[1];
    const orgNameWithoutDomain = orgName.split('.')[0];

    let connectionProfile = JSON.parse(fs.readFileSync(
        path.join(testNetworkRoot,
            'organizations/peerOrganizations',
            orgName,
            `/connection-${orgNameWithoutDomain}.json`), 'utf8')
    );

    let connectionOptions = {
        identity: identityLabel,
        wallet: wallet,
        discovery: { enabled: true, asLocalhost: true }
    };

    await gateway.connect(connectionProfile, connectionOptions);
    const network = await gateway.getNetwork('mychannel');
    return network.getContract('water_donation');
}

app.post('/api/send-donation', async (req, res) => {
    try {
        const { functionName, args } = req.body;
        const identityLabel = req.headers['identitylabel'];
        const contract = await getContract(identityLabel);

        const response = await contract.submitTransaction(functionName, ...args);
        res.status(200).json({ message: 'Transaction submitted successfully', transaction: response.toString() });
    } catch (error) {
        console.error(`Error processing transaction: ${error}`);
        if (error.message.includes('does not exist')) {
            res.status(404).json({ error: `Donation with ID ${donationId} does not exist` });
        } else if (error.message.includes('Unauthorized access')) {
            res.status(403).json({ error: 'You do not have permission to perform this action' });
        } else if (error.message.includes('No valid responses from any peers')) {
            res.status(500).json({ error: 'No valid responses from any peers. Unauthorized access - Org3MSP cannot write' });
        } else {
            res.status(500).json({ error: 'Failed to fetch donation' });
        }
    } finally {
        gateway.disconnect();
    }
});

app.get('/api/query-donation/:donationId', async (req, res) => {
    const { donationId } = req.params;
    try {
        const identityLabel = req.headers['identitylabel'];
        const contract = await getContract(identityLabel);

        const response = await contract.evaluateTransaction('queryDonation', donationId);
        res.status(200).json({ message: 'Query executed successfully', transaction: JSON.parse(response.toString()) });
    } catch (error) {
        console.error(`Error processing transaction: ${error}`);
        if (error.message.includes('does not exist')) {
            res.status(404).json({ error: `Donation with ID ${donationId} does not exist` });
        } else if (error.message.includes('Unauthorized access')) {
            res.status(403).json({ error: 'You do not have permission to perform this action' });
        } else {
            res.status(500).json({ error: 'Failed to fetch donation' });
        }
    } finally {
        gateway.disconnect();
    }
});

app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`);
});
