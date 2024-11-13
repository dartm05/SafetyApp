import {Error} from "./base.error";

export class NoTripFoundError extends Error {
  constructor() {
    super(
      404,
      "No Trips Found",
      "Please create a trip before sending a message or consulting the dashboard",
      "Not Found"
    );
  }
}
