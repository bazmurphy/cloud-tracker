import request from "supertest";
import { app, server } from "../index";
import { database } from "../database/database";
import { Trainee, Week, Coursework, TraineeCoursework } from "../types/types";

describe("Route Tests", () => {
  afterAll(async () => {
    database.end();
    server.close();
  });

  it("GET / should return an HTML page", async () => {
    const response = await request(app).get("/");
    expect(response.statusCode).toBe(200);
    expect(response.type).toBe("text/html");
  });

  it("GET /api/trainees should return a list of trainees", async () => {
    const response = await request(app).get("/api/trainees");
    expect(response.status).toBe(200);
    expect(response.body.success).toBe(true);
    expect(response.body.error).toBe(false);
    expect(Array.isArray(response.body.payload)).toBe(true);
    response.body.payload.forEach((trainee: Trainee) => {
      expect(trainee).toHaveProperty("trainee_id");
      expect(trainee.trainee_id).toEqual(expect.any(Number));
      expect(trainee).toHaveProperty("first_name");
      expect(trainee.first_name).toEqual(expect.any(String));
      expect(trainee).toHaveProperty("last_name");
      expect(trainee.last_name).toEqual(expect.any(String));
    });
  });

  it("GET /api/weeks should return a list of weeks", async () => {
    const response = await request(app).get("/api/weeks");
    expect(response.status).toBe(200);
    expect(response.body.success).toBe(true);
    expect(response.body.error).toBe(false);
    expect(Array.isArray(response.body.payload)).toBe(true);
    response.body.payload.forEach((week: Week) => {
      expect(week).toHaveProperty("week_id");
      expect(week.week_id).toEqual(expect.any(Number));
      expect(week).toHaveProperty("week_number");
      expect(week.week_number).toEqual(expect.any(Number));
    });
  });

  it("GET /api/coursework should return a list of coursework", async () => {
    const response = await request(app).get("/api/coursework");
    expect(response.status).toBe(200);
    expect(response.body.success).toBe(true);
    expect(response.body.error).toBe(false);
    expect(Array.isArray(response.body.payload)).toBe(true);
    response.body.payload.forEach((coursework: Coursework) => {
      expect(coursework).toHaveProperty("coursework_id");
      expect(coursework.coursework_id).toEqual(expect.any(Number));
      expect(coursework).toHaveProperty("week_id");
      expect(coursework.week_id).toEqual(expect.any(Number));
      expect(coursework).toHaveProperty("description");
      expect(coursework.description).toEqual(expect.any(String));
    });
  });

  it("GET /api/trainee-coursework should return a list of trainee coursework", async () => {
    const response = await request(app).get("/api/trainee-coursework");
    expect(response.status).toBe(200);
    expect(response.body.success).toBe(true);
    expect(response.body.error).toBe(false);
    expect(Array.isArray(response.body.payload)).toBe(true);
    response.body.payload.forEach((traineeCoursework: TraineeCoursework) => {
      expect(traineeCoursework).toHaveProperty("trainee_id");
      expect(traineeCoursework.trainee_id).toEqual(expect.any(Number));
      expect(traineeCoursework).toHaveProperty("coursework_id");
      expect(traineeCoursework.coursework_id).toEqual(expect.any(Number));
      expect(traineeCoursework).toHaveProperty("in_progress");
      expect(traineeCoursework.in_progress).toEqual(expect.any(Boolean));
      expect(traineeCoursework).toHaveProperty("need_help");
      expect(traineeCoursework.need_help).toEqual(expect.any(Boolean));
      expect(traineeCoursework).toHaveProperty("completed");
      expect(traineeCoursework.completed).toEqual(expect.any(Boolean));
    });
  });
});
