const express = require('express');
const app = express();
const cors = require('cors');

// To fix CORS policy: No 'Access-Control-Allow-Origin' header is present on the requested resource.
app.use(cors());

// Parse JSON requests
app.use(express.json());

// Import the routes
const registrationDonorRoute = require('./routes/registration');

// Use the routes
app.use('/registration/donor', registrationDonorRoute);

// Define the port for the server
const PORT = process.env.port || 3001;

// Start the server
const db = require('./models');
db.sequelize.sync().then(() => {
    app.listen(3001, () => {
        console.log(`CORS-enabled Server is running on port ${PORT}`);
    });
});

