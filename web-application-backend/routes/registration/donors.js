const express = require('express');
const router = express.Router();
// Import then Create an instance of Donors Module
const DonorsModule = require('../../modules/donorsModule');
const donorsModule = new DonorsModule();
// Pagination Helper
const PaginationUtil = require('../../util/paginationUtil');
const paginationUtil = new PaginationUtil();

// GET endpoint to get donors
router.get('/get', async (req, res) => {
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
router.get('/get/:id', async (req, res) => {
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
router.post('/register', async (req, res) => {
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

module.exports = router;