import { Pool } from "pg";

const environmentVariableDB_SSL = Boolean(process.env.DB_SSL);

export const database = new Pool({
  connectionString: process.env.DB_CONNECTION_STRING,
  // This property controls whether or not to reject connections that are made to servers with self-signed or invalid SSL certificates.
  // Set it to false to disable SSL/TLS verification.
  // Enable when Hosted / Disable when Dev/Testing
  ssl: { rejectUnauthorized: environmentVariableDB_SSL },
});

database.connect((error, client) => {
  if (error) {
    return console.error(
      "Error: Could Not Connect To PostgreSQL Database",
      error.stack
    );
  }
  console.log("Success: Connected To PostgreSQL Database");
  client.release();
});
