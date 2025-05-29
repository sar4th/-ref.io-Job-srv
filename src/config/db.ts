import { Pool } from "pg";
import { config } from ".";

export const db = new Pool({
  connectionString: config.DB_HOST,
});

async function connectWithRetry(retries = 5, delayMs = 3000) {
  for (let i = 0; i < retries; i++) {
    try {
      await db.query("SELECT 1");
      console.log("Connected to Postgres!");
      return;
    } catch (err) {
      console.log(`Postgres not ready yet. Retry ${i + 1}/${retries}`);
      await new Promise((res) => setTimeout(res, delayMs));
    }
  }
  throw new Error("Could not connect to Postgres");
}

connectWithRetry().catch((err) => {
  console.error(err);
  process.exit(1);
});
