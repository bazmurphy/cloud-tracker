import express from "express";
import path from "path";
import {
  getAllTrainees,
  getAllWeeks,
  getAllCoursework,
  getAllTraineeCoursework,
  getSpecificTraineeSpecificCoursework,
  putSpecificTraineeSpecificCoursework,
  getClientIP,
} from "../controllers/trackerController";
import { measureLatencyMiddleware } from "../middleware/measureLatencyMiddleware";
import { Request, Response } from "express";

export const trackerRouter = express.Router();

// define where the static folder exists ../../public
trackerRouter.use(express.static(path.join(__dirname, "../../public")));

// serve the ../../public/index.html to /api (instead of /)
trackerRouter.get("/", (req: Request, res: Response) => {
  res.sendFile(path.join(__dirname, "../../public/index.html"));
});

trackerRouter.get("/trainees", measureLatencyMiddleware, getAllTrainees);
trackerRouter.get("/weeks", measureLatencyMiddleware, getAllWeeks);
trackerRouter.get("/coursework", measureLatencyMiddleware, getAllCoursework);
trackerRouter.get(
  "/trainee-coursework",
  measureLatencyMiddleware,
  getAllTraineeCoursework
);
trackerRouter.get(
  "/trainee-coursework/trainee=:traineeId&coursework=:courseworkId",
  measureLatencyMiddleware,
  getSpecificTraineeSpecificCoursework
);
trackerRouter.put(
  "/trainee-coursework/trainee=:traineeId&coursework=:courseworkId",
  measureLatencyMiddleware,
  putSpecificTraineeSpecificCoursework
);

trackerRouter.get("/get-client-ip", getClientIP);
