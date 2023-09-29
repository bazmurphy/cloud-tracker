"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
require("dotenv/config");
const express_1 = __importDefault(require("express"));
const cors_1 = __importDefault(require("cors"));
const morgan_1 = __importDefault(require("morgan"));
const path_1 = __importDefault(require("path"));
const trackerRoutes_1 = require("./routes/trackerRoutes");
const app = (0, express_1.default)();
app.use((0, cors_1.default)());
app.use((0, morgan_1.default)("dev"));
app.use(express_1.default.static(path_1.default.join(__dirname, "..", "public")));
app.use(express_1.default.json());
app.use(express_1.default.urlencoded({ extended: true }));
app.use("/api", trackerRoutes_1.trackerRouter);
app.get("/", (req, res) => {
    res.sendFile("index.html");
});
const port = Number(process.env.PORT) || 4000;
app.listen(port, () => {
    console.log(`Server listening on PORT ${port}`);
});
