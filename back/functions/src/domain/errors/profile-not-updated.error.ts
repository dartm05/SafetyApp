import {Error} from "./base.error";

export class ProfileNotUpdatedError extends Error {
  constructor() {
    super(
      500,
      "Error Updating The Profile",
      "There was an error updating the profile",
      "Not Found"
    );
  }
}
