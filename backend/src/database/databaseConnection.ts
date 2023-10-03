import { Pool } from "pg";

export const database = new Pool({
  connectionString: process.env.DB_CONNECTION_STRING,
  // This property controls whether or not to reject connections that are made to servers with self-signed or invalid SSL certificates.
  // Set it to false to disable SSL/TLS verification.
  // Disable when Local / Enable when Hosted
  ssl: {
    rejectUnauthorized: false,
  },
});

database.connect((error, client) => {
  if (error) {
    return console.error("Error acquiring client", error.stack);
  }
  console.log("Successfully connected to the PostgreSQL database");
  client.release();
});
