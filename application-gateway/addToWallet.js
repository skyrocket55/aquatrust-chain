'use strict';

const fs = require('fs');
const path = require('path');
const { Wallets } = require('fabric-network');
const { Storage } = require('@google-cloud/storage');

const bucketName = 'k8s-fabric';
const testNetworkRoot = 'organizations';
// const serviceAccountKeyFile = '/Users/ciel/hyperledger-fabric/fabric-samples/aquatrust-chain/application-gateway/ciel-428616-38cb8c70eb10.json';
const serviceAccountKeyFile = '/usr/src/gateway/ciel-428616-38cb8c70eb10.json';

async function main() {
    try {
        console.log('Initializing wallet...');
        const wallet = await Wallets.newFileSystemWallet('./wallet');
        // Initialize Storage with serviceAccountKeyFile
        const storage = new Storage({
            keyFilename: serviceAccountKeyFile,
        });

        const predefinedOrgs = [
            {
                name: 'org1.example.com',
                mspId: 'Org1MSP',
                users: ['Admin', 'User1']
            }, {
                name: 'org2.example.com',
                mspId: 'Org2MSP',
                users: ['Admin', 'User1']
            }, {
                name: 'org3.example.com',
                mspId: 'Org3MSP',
                users: ['Admin', 'User1']
            }
        ];

        for (const org of predefinedOrgs) {
            const credPath = path.join(testNetworkRoot, 'peerOrganizations', org.name, 'users');
            console.log('credPath: ', credPath);
            for (const user of org.users) {
                const mspFolderPath = path.join(credPath, `${user}@${org.name}`, 'msp');
                console.log('mspFolderPath: ', mspFolderPath);

                // Read certificate file from GCS
                const [certFiles] = await storage.bucket(bucketName).getFiles({ prefix: path.join(mspFolderPath, 'signcerts') });
                if (!certFiles.length) {
                    throw new Error(`No certificate files found in ${path.join(mspFolderPath, 'signcerts')}`);
                }
                const certFile = certFiles.find(file => file.name.endsWith('.pem'));
                const certContents = await certFile.download();
                const cert = certContents.toString();
                console.log('cert: ', cert);

                // Read key file from GCS
                const [keyFiles] = await storage.bucket(bucketName).getFiles({ prefix: path.join(mspFolderPath, 'keystore') });
                if (!keyFiles.length) {
                    throw new Error(`No key files found in ${path.join(mspFolderPath, 'keystore')}`);
                }
                const keyFile = keyFiles.find(file => file.name.endsWith('_sk')); 
                const keyContents = await keyFile.download();
                const key = keyContents.toString();
                console.log('key: ', key);

                const identity = {
                    credentials: {
                        certificate: cert,
                        privateKey: key,
                    },
                    mspId: org.mspId,
                    type: 'X.509',
                };

                const identityLabel = `${user}@${org.name}`;
                await wallet.put(identityLabel, identity);
            }
        }

        console.log('Wallet initialization and data insertion completed successfully.');

    } catch (error) {
        console.error(`Error: ${error.message}`);
        console.error(error.stack);
        process.exitCode = 1;
    }
}

main().then(() => {
    console.log('done');
}).catch((e) => {
    console.error(e);
    console.error(e.stack);
    process.exit(-1);
});
