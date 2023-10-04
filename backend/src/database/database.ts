import { Pool } from "pg";

// Debug
console.log("DEBUG----------");
console.log("process.env.DB_SSL:", process.env.DB_SSL);
console.log("typeof process.env.DB_SSL:", typeof process.env.DB_SSL);

export const database = new Pool({
  connectionString: process.env.DB_CONNECTION_STRING,
  // https://node-postgres.com/features/ssl
  // Enable when Hosted / Disable when Local/Development/Testing
  ssl: process.env.DB_SSL === "true" ? true : false,
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
