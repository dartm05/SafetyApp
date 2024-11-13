import { Error } from "./base.error";

export class ProfileNotCreatedError extends Error {
  constructor() {
    super(
      500,
      "Error Creating New Profile",
      "There was an error creating the profile",
      "Not Found"
    );
  }
}