import { Error } from "./base.error";

export class ProfileNotFoundError extends Error {
  constructor() {
    super(
      404,
      "Error Finding The Profile",
      "There was an error finding the profile",
      "Not Found"
    );
  }
}
