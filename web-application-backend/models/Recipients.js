const { DataTypes } = require('sequelize');

module.exports = (sequelize, Sequelize) => {
    const Recipients = sequelize.define('recipients', {
        ngo_name: {
            type: DataTypes.STRING,
            allowNull: false,
        },
        profile: {
            type: DataTypes.STRING,
            allowNull: true,
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
        date_registered: {
            type: DataTypes.STRING,
            allowNull: true,
        },
        communities_supported: {
            type: DataTypes.STRING,
            allowNull: true,
        },
        water_demand: {
            type: DataTypes.STRING,
            allowNull: true,
        },
        total_donation_received: {
            type: DataTypes.STRING,
            allowNull: true,
        },
    });
    return Recipients;
};