import { database } from "../database/databaseConnection";
import { Request, Response } from "express";

export const getAllTrainees = async (req: Request, res: Response) => {
  try {
    const queryAllTrainees = await database.query(
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
    // console.log(error);
    res
      .status(500)
      .json({ success: false, error: true, message: error.message });
  }
};

export const getAllWeeks = async (req: Request, res: Response) => {
  try {
    const queryAllWeeks = await database.query(
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
    // console.log(error);
    res
      .status(500)
      .json({ success: false, error: true, message: error.message });
  }
};

export const getAllCoursework = async (req: Request, res: Response) => {
  try {
    const queryAllCoursework = await database.query(
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
    // console.log(error);
    res
      .status(500)
      .json({ success: false, error: true, message: error.message });
  }
};

export const getAllTraineeCoursework = async (req: Request, res: Response) => {
  try {
    const queryAllTraineeCoursework = await database.query(
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
    // console.log(error);
    res
      .status(500)
      .json({ success: false, error: true, message: error.message });
  }
};

export const getSpecificTraineeSpecificCoursework = async (
  req: Request,
  res: Response
) => {
  try {
    const courseworkId = req.params.courseworkId;
    const traineeId = req.params.traineeId;

    const querySpecificTraineeSpecificCoursework = await database.query(
      `SELECT * 
        FROM trainee_coursework
        WHERE trainee_id = $1 AND coursework_id = $2`,
      [traineeId, courseworkId]
    );

    // console.log(
    //   "querySpecificTraineeSpecificCoursework:",
    //   querySpecificTraineeSpecificCoursework.rows[0]
    // );

    return res.status(200).json({
      success: true,
      error: false,
      payload: querySpecificTraineeSpecificCoursework.rows[0],
    });
  } catch (error: any) {
    // console.log(error);
    res
      .status(500)
      .json({ success: false, error: true, message: error.message });
  }
};

export const putSpecificTraineeSpecificCoursework = async (
  req: Request,
  res: Response
) => {
  try {
    const traineeId = req.params.traineeId;
    const courseworkId = req.params.courseworkId;
    // console.log("traineeId:", traineeId, "courseworkId:", courseworkId);
    const { in_progress, need_help, completed } = req.body;
    // console.log("req.body:", req.body);

    const querySpecificTraineeSpecificCoursework = await database.query(
      `UPDATE trainee_coursework
        SET in_progress = $1, need_help = $2, completed = $3
        WHERE trainee_id = $4 AND coursework_id = $5
        RETURNING *`,
      [in_progress, need_help, completed, traineeId, courseworkId]
    );
    // console.log(
    //   "querySpecificTraineeSpecificCoursework:",
    //   querySpecificTraineeSpecificCoursework.rows[0]
    // );

    return res.status(200).json({
      success: true,
      error: false,
      payload: querySpecificTraineeSpecificCoursework.rows[0],
    });
  } catch (error: any) {
    // console.log(error);
    res
      .status(500)
      .json({ success: false, error: true, message: error.message });
  }
};
