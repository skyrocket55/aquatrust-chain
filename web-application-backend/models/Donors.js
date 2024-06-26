const { DataTypes } = require('sequelize');

module.exports = (sequelize, Sequelize) => {
    const Donors = sequelize.define('donors', {
        company_name: {
            type: DataTypes.STRING,
            allowNull: false,
        },
        phone: {
            type: DataTypes.STRING,
            allowNull: true,
        },
        email: {
            type: DataTypes.STRING,
            allowNull: true,
        },
        address: {
            type: DataTypes.STRING,
            allowNull: true,
        },
        contact_person: {
            type: DataTypes.STRING,
            allowNull: true,
        },
        donor_type: {
            type:  DataTypes.ENUM('SUPPLIER', 'BUYER'),
            allowNull: false,
        },
        date_joined: {
            type:  DataTypes.STRING,
            allowNull: true,
        },
        donation_allocation: {
            type:  DataTypes.STRING,
            allowNull: false,
        },
    });
    return Donors;
};