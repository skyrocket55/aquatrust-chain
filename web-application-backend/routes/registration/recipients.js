const express = require('express');
const router = express.Router();
// Import then Create an instance of Recipients Module
const RecipientsModule = require('../../modules/recipientsModule');
const recipientsModule = new RecipientsModule();
// Pagination Helper
const PaginationUtil = require('../../util/paginationUtil');
const paginationUtil = new PaginationUtil();

// GET endpoint to get recipients
router.get('/get', async (req, res) => {
    // Destructure query parameters; Set default values to allow pagination if not added in client
    const { page = 1, size = 5 } = req.query;
    try {
        const recipients = await recipientsModule.getRecipientsHistory(page, size);
        const responsePaginated = paginationUtil.getPaginatedData(recipients, page, size);
        res.status(200).json(responsePaginated);
        console.log(`${req.method} ${req.url}`);
    } catch (error) {
        res.status(500).json({
            message:
            error.message || "An error occurred while retrieving recipients."
        });
    }
}); 

// GET endpoint to get a recipient by id
router.get('/get/:id', async (req, res) => {
    const recipient_id = req.params['id'];
    try{
        const recipient = await recipientsModule.getRecipientsById(recipient_id);
        res.status(200).json(recipient)
        console.log(`${req.method} ${req.url}`);
    }
    catch (error) {
        res.status(500).json({
         message: 
            error.message || "An error occurred while retrieving recipients."
        });
    }
});

// POST endpoint to save recipients
router.post('/register', async (req, res) => {
    try {
        const { ngo_name, profile, phone, email, address, contact_person, date_registered, communities_supported, water_demand, total_donation_received } = req.body;
        console.log(`${req.method} ${req.url}`);
        const recipientCreated = await recipientsModule.sendRecipient(ngo_name, profile, phone, email, address, contact_person, date_registered, communities_supported, water_demand, total_donation_received);
        res.status(201).json(recipientCreated);    
    } catch (error) {
        res.status(500).json({
            message:
            error.message || "An error occurred while saving recipient."
        });
    }
});

module.exports = router;