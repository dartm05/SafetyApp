import { Error } from "./base.error";

export class NotFoundError extends Error {
  constructor() {
    super(
      404,
      "Page Not Found",
      "Can't find the requested URL",
      "Not Found"
    );
  }
}
