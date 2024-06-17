const { DataTypes } = require('sequelize');

module.exports = (sequelize, Sequelize) => {
    const Transactions = sequelize.define('donors', {
        source: {
            type: DataTypes.STRING,
            allowNull: false,
        },
        destination: {
            type: DataTypes.STRING,
            allowNull: false,
        },
        amount: {
            type: DataTypes.DECIMAL,
            allowNull: false,
        },
        status: {
            type: DataTypes.ENUM('SUCCESSFUL', 'FAILED', 'PENDING'),
            allowNull: false,
        },
        gasUsed: {
            type: DataTypes.DECIMAL,
            allowNull: true,
        },
        receiptHash: {
            type: DataTypes.STRING,
            allowNull: true,
        },
    });
    return Transactions;
};