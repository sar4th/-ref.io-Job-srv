import * as express from "express";
import { CheckHealthStatus } from "./health.controller";
const router = express.Router();
router.get("/status", CheckHealthStatus);

export default router;
