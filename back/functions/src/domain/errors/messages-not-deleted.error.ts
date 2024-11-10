import { Error } from "./base.error";

export class MessageNotDeletedError extends Error {
  constructor() {
    super(
      500,
      "Error Deleting Messages",
      "There was an error deleting the messages",
      "Not Found"
    );
  }
}