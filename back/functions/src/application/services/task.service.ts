import { ITask } from "../../domain/models/task/task";
import { ITaskUseCase } from "../../domain/usecases/task/task.usecase";

export class TaskService implements ITaskUseCase {
  constructor(private taskDrivenAdapter: ITaskUseCase) {}

  create(userId: string, task: ITask): Promise<ITask | undefined> {
    return this.taskDrivenAdapter.create(userId, task);
  }

  findAll(userId: string): Promise<ITask[]> {
    return this.taskDrivenAdapter.findAll(userId);
  }

  findOne(userId: string, id: string): Promise<ITask | undefined> {
    return this.taskDrivenAdapter.findOne(userId, id);
  }

  update(userId: string, id: string, task: ITask): Promise<ITask | undefined> {
    return this.taskDrivenAdapter.update(userId, id, task);
  }

  remove(userId: string, id: string): Promise<ITask | undefined> {
    return this.taskDrivenAdapter.remove(userId, id);
  }
}
