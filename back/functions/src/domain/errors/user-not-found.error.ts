import { Error } from "./base.error";

export class UserNotFoundError extends Error {
  constructor() {
    super(404, "User Not Found", "The user does not exist.", "Not Found");
  }
}
