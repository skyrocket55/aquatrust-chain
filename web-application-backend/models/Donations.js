const { DataTypes } = require('sequelize');

module.exports = (sequelize, Sequelize) => {
    const Donations = sequelize.define('donations', {
        donor_id: {
            type: DataTypes.STRING,
            allowNull: false,
        },
        recipient_id: {
            type: DataTypes.STRING,
            allowNull: false,
        },
        donation_date: {
            type: DataTypes.STRING,
            allowNull: true,
        },
        amount: {
            type: DataTypes.STRING,
            allowNull: false,
        },
        status: {
            type: DataTypes.ENUM('PENDING', 'COMPLETED', 'CANCELLED'),
            allowNull: false,
        },
        comments: {
            type:  DataTypes.STRING,
            allowNull: true,
        },
    });
    return Donations;
};