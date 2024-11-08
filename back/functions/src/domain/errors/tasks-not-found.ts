import { Error } from "./base.error";
export class TasksNotFoundError extends Error {
  constructor() {
    super(
      404,
      "Tasks Not Found",
      "There was an error retrieving the tasks",
      "Not Found"
    );
  }
}
