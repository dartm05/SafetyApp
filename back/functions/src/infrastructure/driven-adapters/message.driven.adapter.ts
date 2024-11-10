import { db } from "../../index";
import { IMessage } from "../../domain/models/message/message";
import { IMessageUseCase } from "../../domain/usecases/message/message.usecase";

export class MessageDrivenAdapter implements IMessageUseCase {
  async create(
    userId: string,
    message: IMessage
  ): Promise<IMessage | undefined> {
    const newMessage = await db
      .collection("users")
      .doc(userId)
      .collection("messages")
      .add(message)
      .then((docRef) => {
        return { ...message, id: docRef.id };
      });
    return newMessage;
  }

  async findAll(userId: string): Promise<IMessage[]> {
    const querySnapshot = await db
      .collection("users")
      .doc(userId)
      .collection("messages")
      .get();
    return querySnapshot.docs.map((doc) => {
      const data = doc.data();
      return { ...data, id: doc.id } as IMessage;
    });
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
