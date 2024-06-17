##### Chaincode Javascript #####

### Components #####
1. collections_config.json - This configuration ensures that sensitive information regarding donations is managed securely according to specified access control policies among different organizations in Hyperledger Fabric.

2. waterDonation.js - donation smart contract

##### Setup #####
1. Bring down the network
> ./network.sh down.

2. Bring up the network,  create MSP with CAs  and channel. Use couchDB as state DB.
> ./network.sh up createChannel -ca -c mychannel -s couchdb

3. Add Org3 to the test network. 
> ./addOrg3.sh up

4. Define all necessary environment variables for Org3MSP.
> export CORE_PEER_TLS_ENABLED=true
> export CORE_PEER_LOCALMSPID="Org3MSP"
> export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/ca.crt
> export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org3.example.com/users/Admin@org3.example.com/msp
> export CORE_PEER_ADDRESS=localhost:11051
> export PATH=${PWD}/../bin:$PATH
> export FABRIC_CFG_PATH=$PWD/../config/

5. Deploy the WaterDonation chaincode.
>  ./network.sh deployCC -ccn water_donation -ccv 1.0 -ccp ../aquatrust-chain/chaincode -ccl javascript -cccg ../aquatrust-chain/chaincode/collections_config.json -ccep "OR('Org1MSP.member','Org2MSP.member','Org3MSP.member')"

6. Export the environment variables for Org3 then install the WaterDonation chaincode on peer0.org3. The chaincode package was previously created by network.sh.

> export CORE_PEER_TLS_ENABLED=true
> export CORE_PEER_LOCALMSPID="Org3MSP"
> export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/ca.crt
> export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org3.example.com/users/Admin@org3.example.com/msp
> export CORE_PEER_ADDRESS=localhost:11051
> export PATH=${PWD}/../bin:$PATH
> export FABRIC_CFG_PATH=$PWD/../config/

peer lifecycle chaincode install water_donation.tar.gz
> It will have an output like this.  submitInstallProposal -> Chaincode code package identifier: water_donation_1.0:0b96549bb1577210c14ce09194e005c166cf2ec7e8ad67b5754077b681a9333b

7. Export the chaincode package then approve a chaincode definition on behalf of Org3. Export the PACKAGE_ID variable based on the peer lifecycle chaincode install output.
> export PACKAGE_ID=water_donation_1.0:0b96549bb1577210c14ce09194e005c166cf2ec7e8ad67b5754077b681a9333b

> peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --channelID mychannel --name water_donation --version 1.0 --package-id $PACKAGE_ID --sequence 1 --tls --cafile ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem --collections-config ../aquatrust-chain/chaincode/collections_config.json --signature-policy "OR('Org1MSP.member','Org2MSP.member','Org3MSP.member')"