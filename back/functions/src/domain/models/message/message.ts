export interface IMessage {
  id: string;
  userId: string;
  message: string;
  timestamp: Date;
  isUser: boolean;
}
