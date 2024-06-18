### Project Setup
1. npm install
2. node app.js

### Features

1. Get a list of donors
2. Get a donor by id
3. Register a new donor
4. Get a list of recipients
5. Get a recipient by id
6. Register a new recipient

### Sample cURL snippets and Response
1. GET http://localhost:3001/registration/donors

```sh
curl --location 'http://localhost:3001/registration/donors?page=1&size=1'
```
Response: 

```json
{
    "totalItems": 8,
    "transactions": [
        {
            "id": 8,
            "company_name": "aquatrust",
            "phone": null,
            "email": null,
            "address": null,
            "contact_person": null,
            "donor_type": "SUPPLIER",
            "date_joined": null,
            "donation_allocation": "3",
            "createdAt": "2024-06-18T02:40:04.953Z",
            "updatedAt": "2024-06-18T02:40:04.953Z"
        }
    ],
    "totalPages": 8,
    "currentPage": 1
}
```

2. GET http://localhost:3001/registration/donors/{id}

```sh
curl --location 'http://localhost:3001/registration/donors/1'
```

Response
```json
{
    "id": 1,
    "company_name": "aquatrust",
    "phone": null,
    "email": null,
    "address": null,
    "contact_person": null,
    "donor_type": "SUPPLIER",
    "date_joined": null,
    "donation_allocation": "3",
    "createdAt": "2024-06-17T19:07:40.085Z",
    "updatedAt": "2024-06-17T19:07:40.085Z"
}
```


3. POST http://localhost:3001/registration/donors/register

```sh
curl --location 'http://localhost:3001/registration/donors/register' \
--header 'Content-Type: application/json' \
--data '{
    "company_name": "aquatrust",
    "donor_type": "SUPPLIER",
    "donation_allocation": "3"
}'
```

Response
```json
{
    "id": 1,
    "company_name": "aquatrust",
    "phone": null,
    "email": null,
    "address": null,
    "contact_person": null,
    "donor_type": "SUPPLIER",
    "date_joined": null,
    "donation_allocation": "3",
    "updatedAt": "2024-06-18T02:40:04.953Z",
    "createdAt": "2024-06-18T02:40:04.953Z"
}
```

4. GET http://localhost:3001/registration/recipients

```sh
curl --location 'http://localhost:3001/registration/recipients?page=1&size=1'
```
Response: 

```json
{
    "totalItems": 2,
    "transactions": [
        {
            "id": 2,
            "ngo_name": "ngo",
            "profile": null,
            "phone": null,
            "email": null,
            "address": null,
            "contact_person": null,
            "date_registered": null,
            "communities_supported": null,
            "water_demand": null,
            "total_donation_received": null,
            "createdAt": "2024-06-18T02:40:52.446Z",
            "updatedAt": "2024-06-18T02:40:52.446Z"
        }
    ],
    "totalPages": 2,
    "currentPage": 1
}
```

5. GET http://localhost:3001/registration/recipients/{id}

```sh
curl --location 'http://localhost:3001/registration/recipients/1'
```

Response
```json
{
    "id": 1,
    "ngo_name": "ngo",
    "profile": null,
    "phone": null,
    "email": null,
    "address": null,
    "contact_person": null,
    "date_registered": null,
    "communities_supported": null,
    "water_demand": null,
    "total_donation_received": null,
    "createdAt": "2024-06-17T19:17:39.451Z",
    "updatedAt": "2024-06-17T19:17:39.451Z"
}
```


6. POST http://localhost:3001/registration/recipients/register

```sh
curl --location 'http://localhost:3001/registration/recipients/register' \
--header 'Content-Type: application/json' \
--data '{
    "ngo_name": "ngo"
}'
```

Response
```json
{
    "id": 3,
    "ngo_name": "ngo",
    "profile": null,
    "phone": null,
    "email": null,
    "address": null,
    "contact_person": null,
    "date_registered": null,
    "communities_supported": null,
    "water_demand": null,
    "total_donation_received": null,
    "updatedAt": "2024-06-18T03:03:25.677Z",
    "createdAt": "2024-06-18T03:03:25.677Z"
}
```