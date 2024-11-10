import express from "express";
import {
  MessageController,
  serviceInjection,
} from "../controllers/message.controller";

const messageApp = express();

messageApp.get("/:userId/messages", (req, res, next) =>
  MessageController.findAll(req, res, next, serviceInjection)
);

messageApp.post("/:userId/messages", (req, res, next) =>
  MessageController.create(req, res, next, serviceInjection)
);

messageApp.delete("/:userId/messages", (req, res, next) =>
  MessageController.deleteAll(req, res, next, serviceInjection)
);
export default messageApp;