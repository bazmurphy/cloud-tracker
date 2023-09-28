import "dotenv/config";
import express from "express";
import cors from "cors";
import morgan from "morgan";
import { trackerRouter } from "./routes/trackerRoutes";

const app = express();

app.use(cors());
app.use(morgan("dev"));

app.use(express.static("public"));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use("/", trackerRouter);

const port = Number(process.env.PORT) || 4000;

app.listen(port, () => {
  console.log(`Server listening on PORT ${port}`);
});
