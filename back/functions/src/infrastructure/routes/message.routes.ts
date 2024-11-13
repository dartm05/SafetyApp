import express from "express";
import {
  MessageController,
  serviceInjection,
  tripServiceInjection,
  profileServiceInjection,
} from "../controllers/message.controller";

const messageApp = express();

messageApp.get("/:userId/messages", (req, res, next) =>
  MessageController.findAll(
    req,
    res,
    next,
    serviceInjection,
    tripServiceInjection,
    profileServiceInjection
  )
);

messageApp.post("/:userId/messages", (req, res, next) =>
  MessageController.create(
    req,
    res,
    next,
    serviceInjection,
    tripServiceInjection,
    profileServiceInjection
  )
);

messageApp.delete("/:userId/messages", (req, res, next) =>
  MessageController.deleteAll(req, res, next, serviceInjection)
);
export default messageApp;
