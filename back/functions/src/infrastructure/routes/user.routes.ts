import express from "express";
import {
  UserController,
  serviceInjection,
} from "../controllers/user.controller";

const userApp = express();
userApp.post("/users", (req, res, next) =>
  UserController.create(req, res, next, serviceInjection)
);
userApp.get("/users/:email", (req, res, next) =>
  UserController.findOne(req, res, next, serviceInjection)
);

export default userApp;
