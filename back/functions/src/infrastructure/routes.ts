import express from "express";
import * as functions from "firebase-functions/v1";
import userApp from "./routes/user.routes";
import profileApp from "./routes/profile.routes";
import tripsApp from "./routes/trip.routes";
import { NotFoundError } from "../domain/errors/not-found.error";
import { errorHandler } from "./controllers/error.controller";

const appRoutes = express();
var cors = require("cors");
appRoutes.use(cors());
appRoutes.use("/users", userApp);
appRoutes.use("/", profileApp);
appRoutes.use("/", tripsApp);

appRoutes.all("*", (req, res, next) => {
  next(new NotFoundError());
});

appRoutes.use(errorHandler);

export const api = functions.https.onRequest(appRoutes);
