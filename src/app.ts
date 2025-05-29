import express from "express";
//import jobRoutes from "./routes/jobs";

const app = express();

// Middleware
app.use(express.json());

// Routes
//app.use("/api/jobs", jobRoutes);

// Health check endpoint
app.get("/health", (_req, res) => {
  res.status(200).send("Job Posting Service is healthy 🚀");
});

export default app;
