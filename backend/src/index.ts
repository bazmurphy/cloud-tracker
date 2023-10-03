import "dotenv/config";
import express from "express";
import cors from "cors";
import morgan from "morgan";
import path from "path";
import { trackerRouter } from "./routes/trackerRoutes";

const app = express();

app.use(cors());
app.use(morgan("dev"));

app.use(express.static(path.join(__dirname, "..", "public")));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use("/api", trackerRouter);

app.get("/", (req, res) => {
  res.sendFile("index.html");
});

// const port = Number(process.env.PORT);
const port = 4000;

app.listen(port, () => {
  console.log(`Server listening on PORT ${port}`);
});
