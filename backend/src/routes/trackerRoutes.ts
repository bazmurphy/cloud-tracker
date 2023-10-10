import express from "express";
import {
  getAllTrainees,
  getAllWeeks,
  getAllCoursework,
  getAllTraineeCoursework,
  getSpecificTraineeSpecificCoursework,
  putSpecificTraineeSpecificCoursework,
} from "../controllers/trackerController";

export const trackerRouter = express.Router();

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
