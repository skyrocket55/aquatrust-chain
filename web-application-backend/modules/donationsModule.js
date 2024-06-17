// Donations Model
const db = require('../models');
const DonationsModel = db.donations;
// Donations Status Enum
const StatusEnum = require('../enums/statusEnum');
const { faker } = require('@faker-js/faker');
const SHA256 = require("crypto-js/sha256");
// Pagination Helper
const PaginationUtil = require('../util/paginationUtil');
const paginationUtil = new PaginationUtil();

class Donations {
    // Get donations list in DESC order
    // Optional params page and size - default values to allow pagination
    async getDonationsHistory(page, size) {
        try {
            const { limit, offset } = paginationUtil.getPagination(page, size);
            const donations = await DonationsModel.findAndCountAll({
                order: [['id', 'DESC']], // Order by donation id in descending order
                limit, // size or num of records per page
                offset, // page * size
            });
            return donations; 
        } catch (error) {
            throw new Error(`Error getting donations history: ${error.message}`);
        }
    }

    async sendDonation(donor_id, recipient_id, donation_date, amount, status, comments) {
        try{
            const newDonation = await DonationsModel.create({
                donor_id,
                recipient_id,
                donation_date,
                amount,
                status,
                comments,
            }); 
            return newDonation;
        }
        catch (err) {
            console.error('Error saving donation:', err);
            return err;
        }
    }
}

module.exports = Donations;