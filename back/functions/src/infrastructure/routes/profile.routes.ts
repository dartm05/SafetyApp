import express from "express";

import {
  ProfileController,
  serviceInjection,
} from "../controllers/profile.controller";

const profileApp = express();

profileApp.get("/:userId/profile", (req, res, next) =>
  ProfileController.findOne(req, res, next, serviceInjection)
);

profileApp.post("/:userId/profile", (req, res, next) =>
  ProfileController.create(req, res, next, serviceInjection)
);

profileApp.put("/:userId/profile", (req, res, next) =>
  ProfileController.update(req, res, next, serviceInjection)
);

export default profileApp;
