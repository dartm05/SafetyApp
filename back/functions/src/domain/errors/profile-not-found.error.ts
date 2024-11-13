import { Error } from "./base.error";

export class ProfileNotFoundError extends Error {
  constructor() {
    super(
      404,
      "Error Finding The Profile",
      "Please create a profile before sending a message or consulting the dashboard",
      "Not Found"
    );
  }
}
