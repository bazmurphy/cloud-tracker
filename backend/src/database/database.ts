import { Pool } from "pg";

export const database = new Pool({
  connectionString: process.env.DB_CONNECTION_STRING,
  // https://node-postgres.com/features/ssl
  // Enable when Hosted / Disable when Dev/Testing
  ssl: Boolean(process.env.DB_SSL),
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
