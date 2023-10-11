import express from "express";
import path from "path";
import {
  getAllTrainees,
  getAllWeeks,
  getAllCoursework,
  getAllTraineeCoursework,
  getSpecificTraineeSpecificCoursework,
  putSpecificTraineeSpecificCoursework,
} from "../controllers/trackerController";
import { Request, Response } from "express";

export const trackerRouter = express.Router();

// define where the static folder exists ../../public
trackerRouter.use(express.static(path.join(__dirname, "..", "..", "public")));

// serve the ../../public/index.html to /api (instead of /)
trackerRouter.get("/", (req: Request, res: Response) => {
  res.sendFile(path.join(__dirname, "..", "..", "public", "index.html"));
});

trackerRouter.get("/trainees", getAllTrainees);
trackerRouter.get("/weeks", getAllWeeks);
trackerRouter.get("/coursework", getAllCoursework);
trackerRouter.get("/trainee-coursework", getAllTraineeCoursework);
trackerRouter.get(
  "/trainee-coursework/trainee=:traineeId&coursework=:courseworkId",
  getSpecificTraineeSpecificCoursework
);
trackerRouter.put(
  "/trainee-coursework/trainee=:traineeId&coursework=:courseworkId",
  putSpecificTraineeSpecificCoursework
);
