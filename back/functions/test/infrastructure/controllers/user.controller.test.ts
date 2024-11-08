import { IUserUseCase } from "../../../src/domain/usecases/user/user.usecase";
import { IUser } from "../../../src/domain/models/user/user";
import { describe, it, beforeEach, expect } from "@jest/globals";
import { jest } from "@jest/globals";
import { getMockReq, getMockRes } from "@jest-mock/express";
import { UserController } from "../../../src/infrastructure/controllers/user.controller";
import { UserNotCreatedError } from "../../../src/domain/errors/user-not-created.error";
import { UserNotFoundError } from "../../../src/domain/errors/user-not-found.error";

describe("UserController", () => {
  let mockUserService: jest.Mocked<IUserUseCase>;
  let mockReq;
  let serviceInjection;

  beforeEach(() => {
    mockUserService = {
      create: jest.fn(),
      findUserByEmail: jest.fn(),
    };
    serviceInjection = jest.fn().mockReturnValue(mockUserService);
  });

  describe("create", () => {
    const { res, next } = getMockRes({
      json: jest.fn() as any,
      status: jest.fn().mockReturnThis(),
    });

    it("should create a user and return user data", async () => {
      mockReq = getMockReq({
        body: { name: "John Doe", email: "john@gmail.com" },
      });

      mockUserService.create.mockResolvedValueOnce(undefined);
      const mockUser = { email: "john@gmail.com", name: "John Doe" } as IUser;
      mockUserService.findUserByEmail.mockResolvedValueOnce(mockUser);

      await UserController.create(mockReq, res, next, serviceInjection);

      // Assert
      expect(mockUserService.create).toHaveBeenCalledWith(mockReq.body);
      expect(mockUserService.findUserByEmail).toHaveBeenCalledWith(
        "john@gmail.com"
      );
      expect(next).not.toHaveBeenCalled();
    });

    it("should call next with UserNotCreatedError if user is not found after creation", async () => {
      mockReq = getMockReq({
        body: { name: "John Doe", email: "john@gmail.com" },
      });

      mockUserService.create.mockResolvedValueOnce(undefined);
      mockUserService.findUserByEmail.mockResolvedValueOnce(undefined);

      await UserController.create(mockReq, res, next, serviceInjection);

      expect(mockUserService.create).toHaveBeenCalledWith(mockReq.body);

      expect(next).toHaveBeenCalledWith(new UserNotCreatedError());
    });
  });

  describe("findOne", () => {
    const { res, next } = getMockRes({
      json: jest.fn() as any,
      status: jest.fn().mockReturnThis(),
    });

    it("should find a user and return user data", async () => {
      mockReq = getMockReq({ params: { email: "test@example.com" } });

      const mockUser = {
        email: "test@example.com",
        id: "1",
        name: "Test User",
      };

      mockUserService.findUserByEmail.mockResolvedValueOnce(mockUser);

      await UserController.findOne(mockReq, res, next, serviceInjection);

      expect(mockUserService.findUserByEmail).toHaveBeenCalledWith(
        "test@example.com"
      );
      expect(res.json).toHaveBeenCalledWith(mockUser);
      expect(next).not.toHaveBeenCalled();
    });

    it("should call next with UserNotFoundError if user is not found", async () => {
      mockReq = getMockReq({ params: { email: "nonexistent@example.com" } });
      mockUserService.findUserByEmail.mockResolvedValueOnce(undefined);

      await UserController.findOne(mockReq, res, next, serviceInjection);

      expect(mockUserService.findUserByEmail).toHaveBeenCalledWith(
        "nonexistent@example.com"
      );
      expect(next).toHaveBeenCalledWith(new UserNotFoundError());
      expect(next).toHaveBeenCalledTimes(1);
    });
  });
});
