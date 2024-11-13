import {IMessage} from "../../models/message/message";

export interface IMessageUseCase {
  create(userId: string, message: IMessage): Promise<IMessage | undefined>;
  findAll(userId: string): Promise<IMessage[]>;
  deleteAll(userId: string): Promise<void>;
}
