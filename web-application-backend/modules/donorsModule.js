// Donors Model
const db = require('../models');
const DonorsModel = db.donors;
// Transactions Status Enum
const StatusEnum = require('../enums/statusEnum');
const { faker } = require('@faker-js/faker');
const SHA256 = require("crypto-js/sha256");
// Pagination Helper
const PaginationUtil = require('../util/paginationUtil');
const paginationUtil = new PaginationUtil();

class Donors {
    // Get transaction list in DESC order
    // Optional params page and size - default values to allow pagination
    async getTransactionHistory(page, size) {
        try {
            const { limit, offset } = paginationUtil.getPagination(page, size);
            const transactions = await DonorsModel.findAndCountAll({
                order: [['createdAt', 'DESC']], // Order by createdAt in descending order
                limit, // size or num of records per page
                offset, // page * size
            });
            return transactions; 
        } catch (error) {
            throw new Error(`Error getting transaction history: ${error.message}`);
        }
    }

}

module.exports = Donors;