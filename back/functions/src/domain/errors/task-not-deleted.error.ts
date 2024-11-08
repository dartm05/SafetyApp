import { Error } from "./base.error";

export class TaskNotDeletedError extends Error {
  constructor() {
    super(
      500,
      "Error Deleting Task",
      "There was an error trying to delete the task",
      "Not deleted"
    );
  }
}
