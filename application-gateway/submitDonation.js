const express = require('express');
const fs = require('fs');
const path = require('path');
const util = require('util');
const { Wallets, Gateway } = require('fabric-network');
const cors = require('cors');
const { Storage } = require('@google-cloud/storage');

const app = express();
const port = 5000;
app.use(cors());

const bucketName = 'k8s-fabric';
const testNetworkRoot = 'organizations'; //'peerOrganizations'
const serviceAccountKeyFile = '/usr/src/gateway/ciel-428616-38cb8c70eb10.json';
// const serviceAccountKeyFile = '/Users/ciel/hyperledger-fabric/fabric-samples/aquatrust-chain/application-gateway/ciel-428616-38cb8c70eb10.json';

const gateway = new Gateway();
let wallet;

const storage = new Storage({
    keyFilename: serviceAccountKeyFile,
});

async function init() {
    wallet = await Wallets.newFileSystemWallet('./wallet');
}

init();

app.use(express.json());

async function getContract(identityLabel) {
    const orgName = identityLabel.split('@')[1];
    const orgNameWithoutDomain = orgName.split('.')[0];
    const filePath = `${testNetworkRoot}/peerOrganizations/${orgName}/connection-${orgNameWithoutDomain}.json`;
    console.log('filePath: ', filePath);
    try {
        const [file] = await storage.bucket(bucketName).file(filePath).download();
        const connectionProfile = JSON.parse(file.toString());
        console.log('file: ', file);
        console.log('connectionProfile before: ', connectionProfile);
        const connectionOptions = {
            identity: identityLabel,
            wallet: wallet,
            discovery: { enabled: true, asLocalhost: false }
        };
        console.log('connectionProfile before gateway.connect: ', connectionProfile);
        await gateway.connect(connectionProfile, connectionOptions);
        console.log('connectionProfile after gateway.connect: ', connectionProfile);
        const network = await gateway.getNetwork('mychannel');
        console.log('=====network====== ', network);
        return network.getContract('water_donation');
    } catch (error) {
        console.error(`Error fetching connection profile: ${error}`);
        throw error;
    }
}

// Add block listener function
async function addBlockListener() {
    console.log('Adding block listener...');
    const network = await gateway.getNetwork('mychannel');

    // Return a promise that resolves once the block listener is added
    return new Promise((resolve, reject) => {
        const listener = async (blockEvent) => {
            try {
                console.log();
                console.log('-----------------Block listener-----------------');
                // Extract block number from the header
                let blockNumber = blockEvent.blockData.header.number.toNumber();
                console.log(`Block number: ${blockNumber}`);
                console.log(`Block header: ${util.inspect(blockEvent.blockData.header, { showHidden: false, depth: 5 })}`);
                console.log(`Block data: ${util.inspect(blockEvent.blockData.data, { showHidden: false, depth: 5 })}`);
                
                console.log('------------------------------------------------');
                console.log();
                // Resolve with block number
                resolve({ blockNumber: blockNumber });
            } catch (error) {
                reject(error);
            }
        };

        // Add the listener function to block events
        network.addBlockListener(listener, { filtered: false }); // { filtered: false } to receive all blocks
    });
}

app.post('/api/send-donation', async (req, res) => {
    let listener;
    try {
        const { functionName, args } = req.body;
        const identityLabel = req.headers['identitylabel'];
        console.log('POST HEADERS: ', req.headers);
        console.log('POST identityLabel: ', identityLabel);
        const contract = await getContract(identityLabel);
        console.log('POST contract: ', contract);
        const response = await contract.submitTransaction(functionName, ...args);
        console.log('POST response: ', response);
        // Call block listener function after submitting transaction
        const { blockNumber } = await addBlockListener();
        
        // Respond with the transaction ID and message
        res.status(200).json({ 
            message: 'Donation submitted successfully',
            blockNumber: blockNumber
        });
    } catch (error) {
        console.error(`Error processing transaction: ${error}`);
        if (error.message.includes('does not exist')) {
            res.status(404).json({ error: `Donation with ID ${donationId} does not exist` });
        } else if (error.message.includes('Unauthorized access')) {
            res.status(403).json({ error: 'You do not have permission to perform this action' });
        } else if (error.message.includes('No valid responses from any peers')) {
            res.status(500).json({ error: 'No valid responses from any peers. Unauthorized access.' });
        } else {
            res.status(500).json({ error: 'Failed to fetch donation' });
        }
    } finally {
        gateway.disconnect();
        if (listener) {
            listener.disconnect(); // Disconnect the block listener if it was successfully created
        }
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
