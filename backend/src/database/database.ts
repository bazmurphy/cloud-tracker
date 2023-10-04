import { Pool } from "pg";

console.log(`DEBUG ----\n
process.env.DB_SSL = ${process.env.DB_SSL}\n
typeof = ${typeof process.env.DB_SSL}`);

export const database = new Pool({
  connectionString: process.env.DB_CONNECTION_STRING,
  // https://node-postgres.com/features/ssl
  // Enable when Hosted / Disable when Local/Development/Testing
  ssl: process.env.DB_SSL === "true" ? { rejectUnauthorized: false } : false,
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
