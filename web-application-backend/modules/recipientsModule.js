// Recipients Model
const db = require('../models');
const RecipientsModel = db.recipients;

const { faker } = require('@faker-js/faker');
const SHA256 = require("crypto-js/sha256");
// Pagination Helper
const PaginationUtil = require('../util/paginationUtil');
const paginationUtil = new PaginationUtil();

class Recipients {
    // Get recipients list in DESC order
    // Optional params page and size - default values to allow pagination
    async getRecipientsHistory(page, size) {
        try {
            const { limit, offset } = paginationUtil.getPagination(page, size);
            const recipients = await RecipientsModel.findAndCountAll({
                order: [['id', 'DESC']], // Order by recipient id in descending order
                limit, // size or num of records per page
                offset, // page * size
            });
            return recipients; 
        } catch (error) {
            throw new Error(`Error getting recipients history: ${error.message}`);
        }
    }

    async sendRecipient(ngo_name, profile, phone, email, address, contact_person, date_registered, communities_supported, water_demand, total_donation_received) {
        try{
            const newRecipient = await RecipientsModel.create({
                ngo_name,
                profile,
                phone,
                email,
                address,
                contact_person,
                date_registered,
                communities_supported,
                water_demand,
                total_donation_received
            }); 
            return newRecipient;
        }
        catch (err) {
            console.error('Error saving recipient:', err);
            return err;
        }
    }
}

module.exports = Recipients;