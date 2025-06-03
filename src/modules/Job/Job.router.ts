import * as express from "express";
import {
  getAllJobs,
  getJob,
  updateJob,
  deleteJob,
  createJob,
} from "./Job.controller";
const router = express.Router();
router.get("/jobs", getAllJobs);
router.get("/jobs/:id", getJob);
router.post("/jobs", createJob);
router.put("/jobs/:id", updateJob);
router.delete("/jobs/:id", deleteJob);

export default router;
