import { describe, it, beforeEach, expect } from "@jest/globals";
import { jest } from "@jest/globals";
import { getMockReq, getMockRes } from "@jest-mock/express";

import { TaskController } from "../../../src/infrastructure/controllers/task.controller";
import { ITaskUseCase } from "../../../src/domain/usecases/task/task.usecase";
import { ITask } from "../../../src/domain/models/task/task";
import { TaskNotCreatedError } from "../../../src/domain/errors/task-not-created";
import { TasksNotFoundError } from "../../../src/domain/errors/tasks-not-found";
import { TaskNotUpdatedError } from "../../../src/domain/errors/task-not-updated.error";
import { TaskNotDeletedError } from "../../../src/domain/errors/task-not-deleted.error";

describe("TaskController", () => {
  let mockTaskService: jest.Mocked<ITaskUseCase>;
  let mockReq;
  let serviceInjection;

  beforeEach(() => {
    mockTaskService = {
      create: jest.fn(),
      findAll: jest.fn(),
      findOne: jest.fn(),
      update: jest.fn(),
      remove: jest.fn(),
    };
    serviceInjection = jest.fn().mockReturnValue(mockTaskService);
  });

  describe("create", () => {
    const task = {
      title: "Test Task",
      description: "Test Description",
      done: false,
    } as ITask;
    mockReq = getMockReq({
      body: task,
      params: { userId: "1" },
    });
    const { res, next } = getMockRes({
      json: jest.fn() as any,
      status: jest.fn().mockReturnThis(),
    });
    it("should create a task successfully", async () => {
      mockTaskService.create.mockResolvedValueOnce(undefined);
      await TaskController.create(mockReq, res, next, serviceInjection);

      expect(mockTaskService.create).toHaveBeenCalled();
    });
    it("should call next with TaskNotCreatedError if task creation fails", async () => {
      mockReq = getMockReq({
        body: task,
        params: { userId: "1" },
      });

      const { res, next } = getMockRes({
        json: jest.fn() as any,
        status: jest.fn().mockReturnThis(),
      });

      mockTaskService.create.mockResolvedValueOnce(undefined);
      await TaskController.create(mockReq, res, next, serviceInjection);
      expect(next).toHaveBeenCalledWith(new TaskNotCreatedError());
    });
  });

  describe("findAll", () => {
    mockReq = getMockReq({
      params: { userId: "1" },
    });

    const { res, next } = getMockRes({
      json: jest.fn() as any,
      status: jest.fn().mockReturnThis(),
    });
    it("should return all tasks", async () => {
      const tasks = [
        {
          id: "1",
          title: "task1",
          description: "description",
          createdAt: new Date("2023-01-01"),
          done: false,
        },
        {
          id: "2",
          title: "task2",
          description: "description",
          createdAt: new Date("2023-01-02"),
          done: true,
        },
      ];

      mockTaskService.findAll.mockResolvedValue(tasks);
      await TaskController.findAll(mockReq, res, next, serviceInjection);

      expect(mockTaskService.findAll).toHaveBeenCalledWith("1");
      expect(res.json).toHaveBeenCalledWith(
        tasks.sort((a, b) => (a.createdAt > b.createdAt ? 1 : -1))
      );
    });
  });

  describe("findOne", () => {
    beforeEach(() => {
      mockReq = getMockReq({
        params: { userId: "1", id: "1" },
      });
    });

    const { res, next } = getMockRes({
      json: jest.fn() as any,
      status: jest.fn().mockReturnThis(),
    });
    it("should return a task", async () => {
      const task = {
        id: "1",
        title: "task1",
        description: "description",
        createdAt: new Date("2023-01-01"),
        done: false,
      };

      mockTaskService.findOne.mockResolvedValue(task);
      await TaskController.findOne(mockReq, res, next, serviceInjection);

      expect(mockTaskService.findOne).toHaveBeenCalledWith("1", "1");
      expect(res.json).toHaveBeenCalledWith(task);
    });

    it("should call next with TasksNotFoundError if task not found", async () => {
      mockTaskService.findOne.mockResolvedValue(undefined);
      await TaskController.findOne(mockReq, res, next, serviceInjection);
      expect(next).toHaveBeenCalledWith(new TasksNotFoundError());
    });
  });

  describe("update", () => {
    const task = {
      title: "Test Task",
      description: "Test Description",
      done: false,
    } as ITask;

    mockReq = getMockReq({
      body: task,
      params: { userId: "1", id: "1" },
    });

    const { res, next } = getMockRes({
      json: jest.fn() as any,
      status: jest.fn().mockReturnThis(),
    });

    it("should update a task successfully", async () => {
      mockTaskService.update.mockResolvedValue(task);
      await TaskController.update(mockReq, res, next, serviceInjection);

      expect(mockTaskService.update).toHaveBeenCalled();
      expect(res.json).toHaveBeenCalledWith(task);
    });

    it("should call next with TaskNotUpdatedError if task update fails", async () => {
      mockTaskService.update.mockResolvedValue(undefined);
      await TaskController.update(mockReq, res, next, serviceInjection);
      expect(next).toHaveBeenCalledWith(new TaskNotUpdatedError());
    });
  });

  describe("remove", () => {
    const task = {
      title: "Test Task",
      description: "Test Description",
      done: false,
    } as ITask;

    mockReq = getMockReq({
      body: task,
      params: { userId: "1", id: "1" },
    });

    const { res, next } = getMockRes({
      json: jest.fn() as any,
      status: jest.fn().mockReturnThis(),
    });
    it("should remove a task successfully", async () => {
      mockTaskService.remove.mockResolvedValue(task);
      await TaskController.remove(mockReq, res, next, serviceInjection);

      expect(mockTaskService.remove).toHaveBeenCalledWith("1", "1");
      expect(res.json).toHaveBeenCalledWith(task);
    });

    it("should call next with TaskNotDeletedError if task removal fails", async () => {
      mockTaskService.remove.mockResolvedValue(undefined);
      await TaskController.remove(mockReq, res, next, serviceInjection);
      expect(next).toHaveBeenCalledWith(new TaskNotDeletedError());
    });
  });
});
