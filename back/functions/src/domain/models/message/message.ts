export interface IMessage {
  id?: string;
  userId: string;
  message: string;
  timestamp?: string;
  isUser: boolean;
}
