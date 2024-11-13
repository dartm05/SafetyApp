import {IMessage} from "../../domain/models/message/message";
import {IMessageUseCase} from "../../domain/usecases/message/message.usecase";

export class MessageService implements IMessageUseCase {
  constructor(private messageDrivenAdapter: IMessageUseCase) {}

  create(userId: string, message: IMessage): Promise<IMessage | undefined> {
    return this.messageDrivenAdapter.create(userId, message);
  }

  findAll(userId: string): Promise<IMessage[]> {
    return this.messageDrivenAdapter.findAll(userId);
  }

  deleteAll(userId: string): Promise<void> {
    return this.messageDrivenAdapter.deleteAll(userId);
  }
}
