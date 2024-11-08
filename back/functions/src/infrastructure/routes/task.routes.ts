import express from "express";
import {
  TaskController,
  serviceInjection,
} from "../controllers/task.controller";

const taskApp = express();

taskApp.get("/:userId/tasks", (req, res, next) =>
  TaskController.findAll(req, res, next, serviceInjection)
);
taskApp.get("/:userId/tasks/:id", (req, res, next) =>
  TaskController.findOne(req, res, next, serviceInjection)
);
taskApp.post("/:userId/tasks", (req, res, next) =>
  TaskController.create(req, res, next, serviceInjection)
);
taskApp.put("/:userId/tasks/:id", (req, res, next) =>
  TaskController.update(req, res, next, serviceInjection)
);
taskApp.delete("/:userId/tasks/:id", (req, res, next) =>
  TaskController.remove(req, res, next, serviceInjection)
);

export default taskApp;
