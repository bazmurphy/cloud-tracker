import "dotenv/config";
import {
  CloudWatchClient,
  PutMetricDataCommand,
  StandardUnit,
} from "@aws-sdk/client-cloudwatch";
// import fs from "fs";
import { Request, Response, NextFunction } from "express";

const config = {
  region: String(process.env.AWS_CLOUDWATCH_REGION),
  credentials: {
    accessKeyId: String(process.env.AWS_CLOUDWATCH_ACCESS_KEY_ID),
    secretAccessKey: String(process.env.AWS_CLOUDWATCH_SECRET_ACCESS_KEY),
  },
};

const cloudWatchClient = new CloudWatchClient(config);

// fs.writeFileSync(`data.csv`, "Route, Request Time, Latency\n");

export const measureLatencyMiddleware = (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const startTime = new Date().getTime();
  // console.log("cloudWatchMiddleware > startTime:", startTime);

  res.on("finish", async () => {
    const endTime = new Date().getTime();
    // console.log("cloudWatchMiddleware > endTime:", endTime);
    const latency = endTime - startTime;
    // console.log("cloudWatchMiddleware > latency:", latency);

    // fs.appendFileSync(`data.csv`, `${req.path}, ${new Date(startTime).toISOString()}, ${latency}\n`);

    const input = {
      Namespace: "CloudTracker",
      MetricData: [
        {
          MetricName: "Route Latency",
          Dimensions: [
            {
              Name: "Route",
              Value: req.path,
            },
          ],
          Value: latency,
          Unit: StandardUnit.Milliseconds,
        },
      ],
    };

    // console.log(
    //   "cloudWatchMiddleware > measureLatencyMiddleware > input:",
    //   input
    // );

    const command = new PutMetricDataCommand(input);

    try {
      const response = await cloudWatchClient.send(command);
      console.log(
        "cloudWatchMiddleware > cloudWatchClient send(command) > response:",
        response
      );
    } catch (error: any) {
      console.error(
        "cloudWatchMiddleware > cloudWatchClient send(command) > error"
      ),
        error.message;
    }
  });

  next();
};
