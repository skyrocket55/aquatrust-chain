const dotenv = require('dotenv');
dotenv.config();

console.log('DB_HOST:', process.env.HOST);
console.log('DB_USER:', process.env.USER);
console.log('DB_PASSWORD:', process.env.PASSWORD);
console.log('DB_NAME:', process.env.DB_NAME);

module.exports = {
  HOST: process.env.HOST,
  USER: process.env.USER,
  PASSWORD: process.env.PASSWORD,
  DB: process.env.DB_NAME, // create aquatrust db on your local
  dialect: "postgres",
  pool: {
    max: 5,
    min: 0,
    acquire: 30000, //maximum time in milliseconds that pool will try to get connection before throwing error
    idle: 10000 //maximum time in milliseconds that a connection can be idle before being released
  }
};