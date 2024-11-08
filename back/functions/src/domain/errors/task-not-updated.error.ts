import { Error } from "./base.error";

export class TaskNotUpdatedError extends Error {
  constructor() {
    super(
      500,
      "Error Updating Task",
      "There was an error trying to update the task",
      "Not updated"
    );
  }
}
