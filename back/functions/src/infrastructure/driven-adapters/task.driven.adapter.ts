import { ITaskUseCase } from "../../domain/usecases/task/task.usecase";
import { ITask } from "../../domain/models/task/task";
import { db } from "../../index";

export class TaskDrivenAdapter implements ITaskUseCase {
  async create(userId: string, task: ITask): Promise<ITask | undefined> {
    const newTask = await db
      .collection("users")
      .doc(userId)
      .collection("tasks")
      .add(task)
      .then((docRef) => {
        return { ...task, id: docRef.id };
      });
    return newTask;
  }

  async findAll(userId: string): Promise<ITask[]> {
    const querySnapshot = await db
      .collection("users")
      .doc(userId)
      .collection("tasks")
      .get();
    return querySnapshot.docs.map((doc) => {
      return { ...doc.data(), id: doc.id } as ITask;
    });
  }

  async findOne(userId: string, id: string): Promise<ITask | undefined> {
    const querySnapshot = await db
      .collection("users")
      .doc(userId)
      .collection("tasks")
      .doc(id)
      .get();
    return { ...querySnapshot.data(), id } as ITask;
  }

  async update(
    userId: string,
    id: string,
    task: ITask
  ): Promise<ITask | undefined> {
    const updated = await db
      .collection("users")
      .doc(userId)
      .collection("tasks")
      .doc(id)
      .update({ ...task })
      .then(() => {
        return task;
      });
    return updated as ITask;
  }

  async remove(userId: string, id: string): Promise<ITask | undefined> {
    const querySnapshot = await db
      .collection("users")
      .doc(userId)
      .collection("tasks")
      .doc(id)
      .get();

    await db
      .collection("users")
      .doc(userId)
      .collection("tasks")
      .doc(id)
      .delete();

    return { ...querySnapshot.data(), id } as ITask;
  }

  async removeAll(userId: string): Promise<void> {
    const querySnapshot = await db
      .collection("users")
      .doc(userId)
      .collection("tasks")
      .get();
    querySnapshot.docs.forEach((doc) => doc.ref.delete());
  }
}
