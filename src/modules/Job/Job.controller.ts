import { Request, Response } from "express";
import { prisma } from "../../config/lib/prisma";

export const createJob = async (req: Request, res: Response) => {
  const {
    title,
    description,
    companyName,
    employmentType,
    location,
    department,
    postedBy,
    status,
  } = req.body;

  const response = await prisma.job.create({
    data: {
      title,
      description,
      companyName,
      employmentType,
      location,
      department,
      postedBy,
      status,
    },
  });
  const payload = {
    title: "dummy",
    description: "dummy",
    companyName: "dummy",
    employmentType: "dummy",
    location: "dummy",
    department: "dummy",
    postedBy: "dummy",
    status: "dummy",
  };
  res.send(response);
};
export const getJob = async (req: Request, res: Response) => {
  const { id } = req.params;

  const jobDetails = await prisma.job.findUnique({
    where: {
      id: Number(id),
    },
  });
  console.log(jobDetails);
  res.send(jobDetails);
};
export const updateJob = (req: Request, res: Response) => {};
export const deleteJob = (req: Request, res: Response) => {};
export const getAllJobs = async (req: Request, res: Response) => {
  const allJobs = await prisma.job.findMany();
  res.send(allJobs);
};
