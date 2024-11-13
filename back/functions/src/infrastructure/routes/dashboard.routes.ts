import express from "express";
import {
  DashboardController,
  dashboardServiceInjection,
  tripServiceInjection,
  profileServiceInjection,
} from "../controllers/dashboard.controller";

const dashboardApp = express();

dashboardApp.get("/:userId/dashboard", (req, res, next) =>
  DashboardController.findOne(req, res, next, dashboardServiceInjection)
);

dashboardApp.post("/:userId/dashboard", (req, res, next) =>
  DashboardController.create(
    req,
    res,
    next,
    dashboardServiceInjection,
    tripServiceInjection,
    profileServiceInjection
  )
);

dashboardApp.delete("/:userId/dashboard/:id", (req, res, next) =>
  DashboardController.delete(req, res, next, dashboardServiceInjection)
);

export default dashboardApp;
