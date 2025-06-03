import dotenv from "dotenv";
dotenv.config();

export const config = {
  port: process.env.PORT || 4000,
  DB_HOST:
    process.env.DATABASE_URL ||
    "postgresql://postgres:bKhPxaWdlLotZMxHOtaJEicDvxsBvybk@postgres.railway.internal:5432/railway",
};
