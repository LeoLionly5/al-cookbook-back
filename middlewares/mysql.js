const mysql = require('mysql');

const dbConnection = mysql.createConnection({
    //host : '10.41.178.111',
    host : '192.168.0.20',
    user:"root",
    password:"root",
    database:"al_db",
    port:3307
});

module.exports = dbConnection;