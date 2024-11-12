import express from "express";
import request from "request";
import * as functions from "firebase-functions/v1";
import userApp from "./routes/user.routes";
import profileApp from "./routes/profile.routes";
import tripsApp from "./routes/trip.routes";
import messagesApp from "./routes/message.routes";
import dashboardApp from "./routes/dashboard.routes";
import { NotFoundError } from "../domain/errors/not-found.error";
import { errorHandler } from "./controllers/error.controller";
import dotenv from "dotenv";

dotenv.config();

const appRoutes = express();
var cors = require("cors");
appRoutes.use(cors());
appRoutes.use("/users", userApp);
appRoutes.use("/", profileApp);
appRoutes.use("/", tripsApp);
appRoutes.use("/", messagesApp);
appRoutes.use("/", dashboardApp);

appRoutes.use("/autocomplete", (req, res) => {
  const place = req.query.place;
  const api_key = process.env.PLACES_API_KEY;
  const url = `https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${place}&key=${api_key}`;

  request(url, (error, response, body) => {
    if (!error && response.statusCode == 200) {
      res.send(body);
    } else {
      res.status(500).send("Error");
    }
  });
});

appRoutes.all("*", (req, res, next) => {
  next(new NotFoundError());
});

appRoutes.use(errorHandler);

export const api = functions.https.onRequest(appRoutes);
