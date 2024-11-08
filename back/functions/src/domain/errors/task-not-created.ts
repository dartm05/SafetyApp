import { Error } from "./base.error";

export class TaskNotCreatedError extends Error {
  constructor() {
    super(
      500,
      "Error Creating New Task",
      "There was an error creating the task",
      "Not Found"
    );
  }
}
