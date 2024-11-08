import { Request, Response } from "express";
import { UserService } from "../../application/services/user.service";
import { IUserUseCase } from "../../domain/usecases/user/user.usecase";
import { UserDrivenAdapter } from "../driven-adapters/user.driven.adapter";
import { UserNotFoundError } from "../../domain/errors/user-not-found.error";
import { UserNotCreatedError } from "../../domain/errors/user-not-created.error";
 
export class UserController {
  static async create(
    { body }: Request,
    res: Response,
    next: any,
    serviceInjection: () => IUserUseCase
  ): Promise<void> {
    const userService = serviceInjection();
    await userService.create(body);
    const user = await userService.findUserByEmail(body.email);
    if (!user) return next(new UserNotCreatedError());
    res.json(user);
  }

  static async findOne(
    { params: { email } }: Request,
    res: Response,
    next: any,
    serviceInjection: () => IUserUseCase
  ): Promise<void> {
    const userService = serviceInjection();
    const user = await userService.findUserByEmail(email);
    if (!user) return next(new UserNotFoundError());
    res.json(user);
  }
}

export function serviceInjection(): IUserUseCase {
  const userDrivenAdapter = new UserDrivenAdapter();
  const userService = new UserService(userDrivenAdapter);
  return userService;
}
