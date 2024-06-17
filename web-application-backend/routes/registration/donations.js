const express = require('express');
const router = express.Router();
// Import then Create an instance of Donations Module
const DonationsModule = require('../../modules/donationsModule');
const donationsModule = new DonationsModule();
// Pagination Helper
const PaginationUtil = require('../../util/paginationUtil');
const paginationUtil = new PaginationUtil();

// GET endpoint to get donations
router.get('/get', async (req, res) => {
    // Destructure query parameters; Set default values to allow pagination if not added in client
    const { page = 1, size = 5 } = req.query;
    try {
        const donations = await donationsModule.getDonationsHistory(page, size);
        const responsePaginated = paginationUtil.getPaginatedData(donations, page, size);
        res.status(200).json(responsePaginated);
        console.log(`${req.method} ${req.url}`);
    } catch (error) {
        res.status(500).json({
            message:
            error.message || "An error occurred while retrieving donations."
        });
    }
}); 

// POST endpoint to save donations
router.post('/register', async (req, res) => {
    try {
        const { donor_id, recipient_id, donation_date, amount, status, comments } = req.body;
        console.log(`${req.method} ${req.url}`);
        const donationCreated = await donationsModule.sendDonation(donor_id, recipient_id, donation_date, amount, status, comments);
        res.status(201).json(donationCreated);    
    } catch (error) {
        res.status(500).json({
            message:
            error.message || "An error occurred while saving donation."
        });
    }
});

module.exports = router;