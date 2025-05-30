import HealthCheck from "../modules/Health/health.router";
import * as express from "express";
const router = express.Router();

// Routers
router.use("/health", HealthCheck);
export default router;
