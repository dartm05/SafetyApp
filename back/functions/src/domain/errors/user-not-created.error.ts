import { Error } from "./base.error";

export class UserNotCreatedError extends Error {
  constructor() {
    super(
      500,
      "Error Creating User",
      "There was an error creating the user",
      "Not created"
    );
  }
}
