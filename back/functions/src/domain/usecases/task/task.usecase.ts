import { ITask } from "../../models/task/task";

export interface ITaskUseCase {
  create(userId: string, task: ITask): Promise<ITask | undefined>;
  findAll(userId: string): Promise<ITask[]>;
  findOne(userId: string, id: string): Promise<ITask | undefined>;
  update(userId: string, id: string, task: ITask): Promise<ITask | undefined>;
  remove(userId: string, id: string): Promise<ITask | undefined>;
}
