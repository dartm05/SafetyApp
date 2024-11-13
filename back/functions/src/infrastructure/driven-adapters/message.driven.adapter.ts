import {db} from "../../index";
import {IMessage} from "../../domain/models/message/message";
import {IMessageUseCase} from "../../domain/usecases/message/message.usecase";

export class MessageDrivenAdapter implements IMessageUseCase {
  async create(
    userId: string,
    message: IMessage
  ): Promise<IMessage | undefined> {
    const newMessage = await db
      .collection("users")
      .doc(userId)
      .collection("messages")
      .add(message);
    const newDate = new Date().toISOString();
    await newMessage.update({
      id: newMessage.id,
      timestamp: newDate,
    });
    return {
      ...message,
      id: newMessage.id,
      timestamp: newDate,
    } as IMessage;
  }

  async findAll(userId: string): Promise<IMessage[]> {
    const querySnapshot = await db
      .collection("users")
      .doc(userId)
      .collection("messages")
      .get();

    if (querySnapshot.empty) {
      return [];
    }
    return querySnapshot.docs
      .map((doc) => {
        const data = doc.data() as IMessage;
        return data;
      })
      .sort(
        (a, b) =>
          new Date(a.timestamp).getTime() - new Date(b.timestamp).getTime()
      );
  }

  async deleteAll(userId: string): Promise<void> {
    const querySnapshot = await db
      .collection("users")
      .doc(userId)
      .collection("messages")
      .get();
    querySnapshot.docs.forEach((doc) => {
      doc.ref.delete();
    });
  }
}
