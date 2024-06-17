const express = require('express');
const app = express();
const cors = require('cors');

// To fix CORS policy: No 'Access-Control-Allow-Origin' header is present on the requested resource.
app.use(cors());

// Parse JSON requests
app.use(express.json());

// Import the routes
const registrationDonorRoute = require('./routes/registration/donors');
const registrationRecipientRoute = require('./routes/registration/recipients');
const registrationDonationRoute = require('./routes/registration/donations');

// Use the routes
app.use('/registration/donors', registrationDonorRoute);
app.use('/registration/recipients', registrationRecipientRoute);
app.use('/registration/donations', registrationDonationRoute);

// Define the port for the server
const PORT = process.env.port || 3001;

// Start the server
const db = require('./models');
db.sequelize.sync().then(() => {
    app.listen(3001, () => {
        console.log(`CORS-enabled Server is running on port ${PORT}`);
    });
});

