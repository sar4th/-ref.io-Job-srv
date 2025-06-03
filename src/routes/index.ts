import HealthCheck from "../modules/Health/health.router";
import JobRouter from "../modules/Job/Job.router";
import * as express from "express";
const router = express.Router();

// Routers
router.use(HealthCheck);
router.use(JobRouter);
export default router;
