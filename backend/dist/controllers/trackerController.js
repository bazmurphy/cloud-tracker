"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.putSpecificTraineeSpecificCoursework = exports.getSpecificTraineeSpecificCoursework = exports.getAllTraineeCoursework = exports.getAllCoursework = exports.getAllWeeks = exports.getAllTrainees = exports.rootRoute = void 0;
const databaseConnection_1 = require("../database/databaseConnection");
const rootRoute = async (req, res) => {
    res.sendFile(__dirname + "/public/index.html");
};
exports.rootRoute = rootRoute;
const getAllTrainees = async (req, res) => {
    try {
        const queryAllTrainees = await databaseConnection_1.database.query(`SELECT *
        FROM trainees
        ORDER BY trainee_id;`);
        return res.status(200).json({
            success: true,
            error: false,
            payload: queryAllTrainees.rows,
        });
    }
    catch (error) {
        // console.log(error);
        res
            .status(500)
            .json({ success: false, error: true, message: error.message });
    }
};
exports.getAllTrainees = getAllTrainees;
const getAllWeeks = async (req, res) => {
    try {
        const queryAllWeeks = await databaseConnection_1.database.query(`SELECT *
        FROM weeks
        ORDER BY week_id;`);
        return res.status(200).json({
            success: true,
            error: false,
            payload: queryAllWeeks.rows,
        });
    }
    catch (error) {
        // console.log(error);
        res
            .status(500)
            .json({ success: false, error: true, message: error.message });
    }
};
exports.getAllWeeks = getAllWeeks;
const getAllCoursework = async (req, res) => {
    try {
        const queryAllCoursework = await databaseConnection_1.database.query(`SELECT *
        FROM coursework
        ORDER BY coursework_id;`);
        return res.status(200).json({
            success: true,
            error: false,
            payload: queryAllCoursework.rows,
        });
    }
    catch (error) {
        // console.log(error);
        res
            .status(500)
            .json({ success: false, error: true, message: error.message });
    }
};
exports.getAllCoursework = getAllCoursework;
const getAllTraineeCoursework = async (req, res) => {
    try {
        const queryAllTraineeCoursework = await databaseConnection_1.database.query(`SELECT *
        FROM trainee_coursework
        ORDER BY trainee_id;`);
        return res.status(200).json({
            success: true,
            error: false,
            payload: queryAllTraineeCoursework.rows,
        });
    }
    catch (error) {
        // console.log(error);
        res
            .status(500)
            .json({ success: false, error: true, message: error.message });
    }
};
exports.getAllTraineeCoursework = getAllTraineeCoursework;
const getSpecificTraineeSpecificCoursework = async (req, res) => {
    try {
        const courseworkId = req.params.courseworkId;
        const traineeId = req.params.traineeId;
        const querySpecificTraineeSpecificCoursework = await databaseConnection_1.database.query(`SELECT * 
        FROM trainee_coursework
        WHERE trainee_id = $1 AND coursework_id = $2`, [traineeId, courseworkId]);
        // console.log(
        //   "querySpecificTraineeSpecificCoursework:",
        //   querySpecificTraineeSpecificCoursework.rows[0]
        // );
        return res.status(200).json({
            success: true,
            error: false,
            payload: querySpecificTraineeSpecificCoursework.rows[0],
        });
    }
    catch (error) {
        // console.log(error);
        res
            .status(500)
            .json({ success: false, error: true, message: error.message });
    }
};
exports.getSpecificTraineeSpecificCoursework = getSpecificTraineeSpecificCoursework;
const putSpecificTraineeSpecificCoursework = async (req, res) => {
    try {
        const traineeId = req.params.traineeId;
        const courseworkId = req.params.courseworkId;
        // console.log("traineeId:", traineeId, "courseworkId:", courseworkId);
        const { in_progress, need_help, completed } = req.body;
        // console.log("req.body:", req.body);
        const querySpecificTraineeSpecificCoursework = await databaseConnection_1.database.query(`UPDATE trainee_coursework
        SET in_progress = $1, need_help = $2, completed = $3
        WHERE trainee_id = $4 AND coursework_id = $5
        RETURNING *`, [in_progress, need_help, completed, traineeId, courseworkId]);
        // console.log(
        //   "querySpecificTraineeSpecificCoursework:",
        //   querySpecificTraineeSpecificCoursework.rows[0]
        // );
        return res.status(200).json({
            success: true,
            error: false,
            payload: querySpecificTraineeSpecificCoursework.rows[0],
        });
    }
    catch (error) {
        // console.log(error);
        res
            .status(500)
            .json({ success: false, error: true, message: error.message });
    }
};
exports.putSpecificTraineeSpecificCoursework = putSpecificTraineeSpecificCoursework;
