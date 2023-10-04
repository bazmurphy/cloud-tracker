import { database } from "../database/database";
import { Request, Response } from "express";
import {
  Trainee,
  Week,
  Coursework,
  TraineeCoursework,
  UpdateTraineeCourseworkRequestBody,
  SuccessReponse,
  FailureResponse,
} from "../types/types";

export const getAllTrainees = async (
  req: Request,
  res: Response<SuccessReponse<Trainee[]> | FailureResponse>
) => {
  try {
    const queryAllTrainees = await database.query<Trainee>(
      `SELECT *
        FROM trainees
        ORDER BY trainee_id;`
    );

    return res.status(200).json({
      success: true,
      error: false,
      payload: queryAllTrainees.rows,
    });
  } catch (error: any) {
    res.status(500).json({
      success: false,
      error: true,
      message: error.message,
    });
  }
};

export const getAllWeeks = async (
  req: Request,
  res: Response<SuccessReponse<Week[]> | FailureResponse>
) => {
  try {
    const queryAllWeeks = await database.query<Week>(
      `SELECT *
        FROM weeks
        ORDER BY week_id;`
    );

    return res.status(200).json({
      success: true,
      error: false,
      payload: queryAllWeeks.rows,
    });
  } catch (error: any) {
    res.status(500).json({
      success: false,
      error: true,
      message: error.message,
    });
  }
};

export const getAllCoursework = async (
  req: Request,
  res: Response<SuccessReponse<Coursework[]> | FailureResponse>
) => {
  try {
    const queryAllCoursework = await database.query<Coursework>(
      `SELECT *
        FROM coursework
        ORDER BY coursework_id;`
    );

    return res.status(200).json({
      success: true,
      error: false,
      payload: queryAllCoursework.rows,
    });
  } catch (error: any) {
    res.status(500).json({
      success: false,
      error: true,
      message: error.message,
    });
  }
};

export const getAllTraineeCoursework = async (
  req: Request,
  res: Response<SuccessReponse<TraineeCoursework[]> | FailureResponse>
) => {
  try {
    const queryAllTraineeCoursework = await database.query<TraineeCoursework>(
      `SELECT *
        FROM trainee_coursework
        ORDER BY trainee_id;`
    );

    return res.status(200).json({
      success: true,
      error: false,
      payload: queryAllTraineeCoursework.rows,
    });
  } catch (error: any) {
    res
      .status(500)
      .json({ success: false, error: true, message: error.message });
  }
};

export const getSpecificTraineeSpecificCoursework = async (
  req: Request,
  res: Response<SuccessReponse<TraineeCoursework> | FailureResponse>
) => {
  try {
    const courseworkId = parseInt(req.params.courseworkId);
    const traineeId = parseInt(req.params.traineeId);

    if (isNaN(courseworkId) || isNaN(traineeId)) {
      return res.status(400).json({
        success: false,
        error: true,
        message: `Invalid courseworkId ${courseworkId} or traineeId ${traineeId}`,
      });
    }

    const querySpecificTraineeSpecificCoursework =
      await database.query<TraineeCoursework>(
        `SELECT * 
        FROM trainee_coursework
        WHERE trainee_id = $1 AND coursework_id = $2`,
        [traineeId, courseworkId]
      );

    return res.status(200).json({
      success: true,
      error: false,
      payload: querySpecificTraineeSpecificCoursework.rows[0],
    });
  } catch (error: any) {
    res
      .status(500)
      .json({ success: false, error: true, message: error.message });
  }
};

export const putSpecificTraineeSpecificCoursework = async (
  req: Request,
  res: Response<SuccessReponse<TraineeCoursework> | FailureResponse>
) => {
  try {
    const traineeId = parseInt(req.params.traineeId);
    const courseworkId = parseInt(req.params.courseworkId);

    const {
      in_progress,
      need_help,
      completed,
    }: UpdateTraineeCourseworkRequestBody = req.body;

    if (
      isNaN(traineeId) ||
      isNaN(courseworkId) ||
      typeof in_progress !== "boolean" ||
      typeof need_help !== "boolean" ||
      typeof completed !== "boolean"
    ) {
      return res.status(400).json({
        success: false,
        error: true,
        message: `Invalid Request Body ${req.body}`,
      });
    }

    const querySpecificTraineeSpecificCoursework =
      await database.query<TraineeCoursework>(
        `UPDATE trainee_coursework
        SET in_progress = $1, need_help = $2, completed = $3
        WHERE trainee_id = $4 AND coursework_id = $5
        RETURNING *`,
        [in_progress, need_help, completed, traineeId, courseworkId]
      );

    return res.status(200).json({
      success: true,
      error: false,
      payload: querySpecificTraineeSpecificCoursework.rows[0],
    });
  } catch (error: any) {
    res
      .status(500)
      .json({ success: false, error: true, message: error.message });
  }
};
