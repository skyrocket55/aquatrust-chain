
##### Setup #####
1. Install the application dependencies. 
> npm install

2. Run addToWallet.js. As a result, you should see a newly created wallet folder containing the identities of User1 and Admin from all three organizations.
> node addToWallet

3. Test the gateway.
> node submitDonation

> POST send-donation -- Org3 (donation recipient) doesn't have write access
curl --location 'http://localhost:3000/api/send-donation' \
--header 'identitylabel: User1@org3.example.com' \
--header 'Content-Type: application/json' \
--data '{
    "functionName": "createDonation",
    "args": ["don3", "10ABC", "888", 88000]
}'

Response: 
{
    "error": "You do not have permission to perform this action"
}

> POST send-donation -- Org1 (Donor Supplier/BWT) and Org2 (Buyer) have write access
curl --location 'http://localhost:3000/api/send-donation' \
--header 'identitylabel: User1@org1.example.com' \
--header 'Content-Type: application/json' \
--data '{
    "functionName": "createDonation",
    "args": ["don3", "10ABC", "888", 88000]
}'

Response:
{
    "message": "Transaction submitted successfully",
    "transaction": ""
}

> GET donation
curl --location 'http://localhost:3000/api/query-donation/don3' \
--header 'identitylabel: User1@org1.example.com'

{
    "message": "Query executed successfully",
    "transaction": {
        "amount": 88000,
        "dateUTC": "2024-06-17T15:33:29.934Z",
        "donationId": "don3",
        "donorId": "32544c7be36fe88a3ee1a9507229a401a36f926f7d8d536a5ce973a11cd27b2d",
        "recipientId": "5e968ce47ce4a17e3823c29332a39d049a8d0afb08d157eb6224625f92671a51",
        "status": 2
    }
}