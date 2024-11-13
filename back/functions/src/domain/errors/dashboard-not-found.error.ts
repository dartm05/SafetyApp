import {Error} from "./base.error";

export class DashboardNotFoundError extends Error {
  constructor() {
    super(404, "Dashboard Not Found", "Dashboard does not exist", "error");
  }
}
