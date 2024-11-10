import { Error } from "./base.error";

export class MessageNotCreatedError extends Error {
  constructor() {
    super(
      500,
      "Error Creating Sending Message",
      "There was an error creating the message",
      "Not Found"
    );
  }
}