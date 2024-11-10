import { Request, Response } from "express";
import { IMessageUseCase } from "../../domain/usecases/message/message.usecase";
import { MessageService } from "../../application/services/message.service";
import { MessageDrivenAdapter } from "../driven-adapters/message.driven.adapter";
import { MessageNotCreatedError } from "../../domain/errors/message-not-created.error";
import { MessageNotDeletedError } from "../../domain/errors/messages-not-deleted.error";

export class MessageController {
  static async create(
    { params: { userId }, body }: Request<{ userId: string }>,
    res: Response,
    next: any,
    serviceInjection: () => IMessageUseCase
  ): Promise<void> {
    const messageService = serviceInjection();
    const success = await messageService.create(userId, body);
    if (!success) return next(new MessageNotCreatedError());
    res.json(success);
  }

  static async findAll(
    { params: { userId } }: Request<{ userId: string }>,
    res: Response,
    next: any,
    serviceInjection: () => IMessageUseCase
  ): Promise<void> {
    const messageService = serviceInjection();
    const messages = await messageService.findAll(userId);
    res.json(messages);
  }

  static async deleteAll(
    { params: { userId } }: Request<{ userId: string }>,
    res: Response,
    next: any,
    serviceInjection: () => IMessageUseCase
  ): Promise<void> {
    const messageService = serviceInjection();
    await messageService
      .deleteAll(userId)
      .catch(() => next(new MessageNotDeletedError()));
    res.json();
  }
}
export function serviceInjection(): IMessageUseCase {
  const messageDrivenAdapter = new MessageDrivenAdapter();
  const messageService = new MessageService(messageDrivenAdapter);
  return messageService;
}
