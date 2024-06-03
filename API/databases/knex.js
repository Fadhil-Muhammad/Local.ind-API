require('dotenv').config();

module.exports = {
    development: {
      client: 'pg',
      connection: {
        host: process.env.DB_HOST,
        user: process.env.DB_USER,
        password: process.env.DB_PASS,
        database: process.env.DB_NAME
      },
      migrations: {
        directory: './migrations'
      },
      seeds: {
        directory: './seeds'
      }
    },
    // production: {
    //   client: 'pg',
    //   connection: process.env.DATABASE_URL, // Assuming you're using a database URL for production
    //   migrations: {
    //     directory: './migrations'
    //   },
    //   seeds: {
    //     directory: './seeds'
    //   }
    // }
  };