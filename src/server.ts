import app from "./app";
import { config } from "./config";
import { db } from "./config/db";

const PORT = config.port;

app.listen(PORT, async () => {
  await db.connect();
  console.log(`✅ Job Posting Service is running on http://localhost:${PORT}`);
});
