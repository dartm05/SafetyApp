export class Error {
  statusCode: number;
  status: string;
  message: string;
  title: string;

  constructor(
    statusCode: number,
    title: string,
    message: string,
    status: string,
  ) {
    this.statusCode = statusCode;
    this.status = status;
    this.message = message;
    this.title = title;
  }
}
