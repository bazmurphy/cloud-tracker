"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.trackerRouter = void 0;
const express_1 = __importDefault(require("express"));
const trackerController_1 = require("../controllers/trackerController");
exports.trackerRouter = express_1.default.Router();
exports.trackerRouter.get("/", trackerController_1.rootRoute);
exports.trackerRouter.get("/trainees", trackerController_1.getAllTrainees);
exports.trackerRouter.get("/weeks", trackerController_1.getAllWeeks);
exports.trackerRouter.get("/coursework", trackerController_1.getAllCoursework);
exports.trackerRouter.get("/trainee-coursework", trackerController_1.getAllTraineeCoursework);
exports.trackerRouter.get("/trainee-coursework/trainee=:traineeId&coursework=:courseworkId", trackerController_1.getSpecificTraineeSpecificCoursework);
exports.trackerRouter.put("/trainee-coursework/trainee=:traineeId&coursework=:courseworkId", trackerController_1.putSpecificTraineeSpecificCoursework);
