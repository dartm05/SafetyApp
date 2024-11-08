import { Request, Response } from "express";
import { ITaskUseCase } from "../../domain/usecases/task/task.usecase";
import { TaskService } from "../../application/services/task.service";
import { TaskDrivenAdapter } from "../driven-adapters/task.driven.adapter";
import { TaskNotCreatedError } from "../../domain/errors/task-not-created";
import { TasksNotFoundError } from "../../domain/errors/tasks-not-found";
import { TaskNotDeletedError } from "../../domain/errors/task-not-deleted.error";
import { TaskNotUpdatedError } from "../../domain/errors/task-not-updated.error";

export class TaskController {
  static async create(
    { params: { userId }, body }: Request<{ userId: string }>,
    res: Response,
    next: any,
    serviceInjection: () => ITaskUseCase
  ): Promise<void> {
    const taskService = serviceInjection();
    const createdAt = new Date().toISOString();
    body = { ...body, createdAt: createdAt };
    const success = await taskService.create(userId, body);
    if (!success) return next(new TaskNotCreatedError());
    res.json(success);
  }

  static async findAll(
    { params: { userId } }: Request<{ userId: string }>,
    res: Response,
    next: any,
    serviceInjection: () => ITaskUseCase
  ): Promise<void> {
    const taskService = serviceInjection();
    const tasks = (await taskService.findAll(userId)).sort((a, b) => {
      return a.createdAt > b.createdAt ? 1 : -1;
    });
    res.json(tasks);
  }

  static async findOne(
    { params: { userId, id } }: Request<{ userId: string; id: string }>,
    res: Response,
    next: any,
    serviceInjection: () => ITaskUseCase
  ): Promise<void> {
    const taskService = serviceInjection();
    const task = await taskService.findOne(userId, id);
    if (!task) return next(new TasksNotFoundError());
    res.json(task);
  }

  static async update(
    { params: { userId, id }, body }: Request<{ userId: string; id: string }>,
    res: Response,
    next: any,
    serviceInjection: () => ITaskUseCase
  ): Promise<void> {
    const taskService = serviceInjection();
    const success = await taskService.update(userId, id, body);
    if (!success) return next(new TaskNotUpdatedError());
    res.json(success);
  }

  static async remove(
    { params: { userId, id } }: Request<{ userId: string; id: string }>,
    res: Response,
    next: any,
    serviceInjection: () => ITaskUseCase
  ): Promise<void> {
    const taskService = serviceInjection();
    const success = await taskService.remove(userId, id);
    if (!success) return next(new TaskNotDeletedError());
    res.json(success);
  }
}

export function serviceInjection(): ITaskUseCase {
  const taskDrivenAdapter = new TaskDrivenAdapter();
  const taskService = new TaskService(taskDrivenAdapter);
  return taskService;
}
