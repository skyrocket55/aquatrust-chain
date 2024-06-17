
##### Setup #####
1. Install the application dependencies. 
> npm install

2. Run addToWallet.js. As a result, you should see a newly created wallet folder containing the identities of User1 and Admin from all three organizations.
> node addToWallet

3. Test the gateway.
> node submitDonation

> POST send-donation -- Org3 (donation recipient) doesn't have write access
curl --location 'http://localhost:3000/api/send-donation' \
--header 'identitylabel: Admin@org3.example.com' \
--header 'Content-Type: application/json' \
--data '{
    "functionName": "createDonation",
    "args": ["don4", "555", "777", 10000]
}'

Response: 
{
    "error": "You do not have permission to perform this action"
}

> POST send-donation -- Org1 (Donor Supplier/BWT) and Org2 (Buyer) have write access
curl --location 'http://localhost:3000/api/send-donation' \
--header 'identitylabel: Admin@org1.example.com' \
--header 'Content-Type: application/json' \
--data '{
    "functionName": "createDonation",
    "args": ["don4", "555", "777", 10000]
}'

Response:
{
    "message": "Transaction submitted successfully",
    "transaction": ""
}

> GET donation
curl --location 'http://localhost:3000/api/query-donation/don2' \
--header 'identitylabel: Admin@org2.example.com'