const express = require('express');
const router = express.Router();
// Import then Create an instance of Donors Module
const DonorsModule = require('../modules/donorsModule');
const donorsModule = new DonorsModule();
// Import then Create an instance of Recipients Module
const RecipientsModule = require('../modules/recipientsModule');
const recipientsModule = new RecipientsModule();
// Pagination Helper
const PaginationUtil = require('../util/paginationUtil');
const paginationUtil = new PaginationUtil();

// GET endpoint to get donors
router.get('/donors', async (req, res) => {
    // Destructure query parameters; Set default values to allow pagination if not added in client
    const { page = 1, size = 5 } = req.query;
    try {
        const donors = await donorsModule.getDonorsHistory(page, size);
        const responsePaginated = paginationUtil.getPaginatedData(donors, page, size);
        res.status(200).json(responsePaginated);
        console.log(`${req.method} ${req.url}`);
    } catch (error) {
        res.status(500).json({
            message:
            error.message || "An error occurred while retrieving donors."
        });
    }
}); 

// GET endpoint to get a donor by id
router.get('/donors/:id', async (req, res) => {
    const donor_id = req.params['id'];
    try{
        const donor = await donorsModule.getDonorsById(donor_id);
        res.status(200).json(donor)
        console.log(`${req.method} ${req.url}`);
    }
    catch (error) {
        res.status(500).json({
         message: 
            error.message || "An error occurred while retrieving donors."
        });
    }
});

// POST endpoint to save donors
router.post('/donors/register', async (req, res) => {
    try {
        const { company_name, phone, email, address, contact_person, donor_type, date_joined, donation_allocation } = req.body;
        console.log(`${req.method} ${req.url}`);
        const donorCreated = await donorsModule.sendDonor(company_name, phone, email, address, contact_person, donor_type, date_joined, donation_allocation);
        res.status(201).json(donorCreated);    
    } catch (error) {
        res.status(500).json({
            message:
            error.message || "An error occurred while saving donor."
        });
    }
});

// GET endpoint to get recipients
router.get('/recipients', async (req, res) => {
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
router.get('/recipients/:id', async (req, res) => {
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
router.post('/recipients/register', async (req, res) => {
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