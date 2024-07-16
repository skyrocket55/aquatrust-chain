const express = require('express');
const app = express();
const cors = require('cors');
require('dotenv').config(); // Load environment variables from .env file
// To fix CORS policy: No 'Access-Control-Allow-Origin' header is present on the requested resource.
app.use(cors());

// Parse JSON requests
app.use(express.json());

// Import the routes
const DonationRoute = require('./routes/donations');
const registrationRoute = require('./routes/registration');

// Use the routes
app.use('/registration', registrationRoute);
app.use('/donations', DonationRoute);

// Define the port for the server
const PORT = process.env.port || 3008;

// Start the server
const db = require('./models');
db.sequelize.sync().then(() => {
    app.listen(PORT, () => {
        console.log(`CORS-enabled Server is running on port ${PORT}`);
    });
});

