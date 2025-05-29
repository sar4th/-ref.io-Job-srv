import dotenv from "dotenv";
dotenv.config();

export const config = {
  port: process.env.PORT || 4000,
  DB_HOST:
    process.env.DATABASE_URL ||
    "postgres://postgres:postgres@localhost:5432/job_posting",
};
