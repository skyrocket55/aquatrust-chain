// Donors Model
const db = require('../models');
const DonorsModel = db.donors;
// Donors Type Enum
const DonorTypeEnum = require('../enums/donorTypeEnum');
const { faker } = require('@faker-js/faker');
const SHA256 = require("crypto-js/sha256");
// Pagination Helper
const PaginationUtil = require('../util/paginationUtil');
const paginationUtil = new PaginationUtil();

class Donors {
    // Get donors list in DESC order
    // Optional params page and size - default values to allow pagination
    async getDonorsHistory(page, size) {
        try {
            const { limit, offset } = paginationUtil.getPagination(page, size);
            const donors = await DonorsModel.findAndCountAll({
                order: [['id', 'DESC']], // Order by donor id in descending order
                limit, // size or num of records per page
                offset, // page * size
            });
            return donors; 
        } catch (error) {
            throw new Error(`Error getting donors history: ${error.message}`);
        }
    }

    async sendDonor(company_name, phone, email, address, contact_person, donor_type, date_joined, donation_allocation) {
        try{
            const newDonor = await DonorsModel.create({
                company_name,
                phone,
                email,
                address,
                contact_person,
                donor_type,
                date_joined,
                donation_allocation,
            }); 
            return newDonor;
        }
        catch (err) {
            console.error('Error saving donor:', err);
            return err;
        }
    }
}

module.exports = Donors;