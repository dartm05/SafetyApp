import {Request, Response} from "express";
import {IMessageUseCase} from "../../domain/usecases/message/message.usecase";
import {MessageService} from "../../application/services/message.service";
import {MessageDrivenAdapter} from "../driven-adapters/message.driven.adapter";
import {MessageNotCreatedError} from "../../domain/errors/message-not-created.error";
import {MessageNotDeletedError} from "../../domain/errors/messages-not-deleted.error";
import {IProfileUseCase} from "../../domain/usecases/profile/profile.usecase";
import {ITripUseCase} from "../../domain/usecases/trip/trip.usecase";
import {chat} from "../driven-adapters/prediction.adapter";
import {TripDrivenAdapter} from "../driven-adapters/trip.driven.adappter";
import {TripService} from "../../application/services/trip.service";
import {ProfileService} from "../../application/services/profile.service";
import {ProfileDrivenAdapter} from "../driven-adapters/profile.driven.adapter";
import {NoTripFoundError} from "../../domain/errors/no-trip-found.error";
import {ProfileNotFoundError} from "../../domain/errors/profile-not-found.error";
import {IMessage} from "../../domain/models/message/message";

export class MessageController {
  static async create(
    {params: {userId}, body}: Request<{ userId: string }>,
    res: Response,
    next: any,
    serviceInjection: () => IMessageUseCase,
    tripServiceInjection: () => ITripUseCase,
    profileServiceInjection: () => IProfileUseCase
  ): Promise<void> {
    const messageService = serviceInjection();

    const tripService = tripServiceInjection();
    const trip = await tripService
      .findAll(userId)
      .then((trips) => trips[trips.length - 1]);

    if (!trip) return next(new NoTripFoundError());
    const profileService = profileServiceInjection();
    const profile = await profileService.findOne(userId);

    if (!profile) return next(new ProfileNotFoundError());

    const success = await messageService.create(userId, body);
    if (!success) return next(new MessageNotCreatedError());

    const messages = await messageService.findAll(userId);

    const response = await chat(trip, profile, messages, success);

    const messageResponse: IMessage = {
      message: response,
      userId: userId,
      isUser: false,
    };
    const newMessage = await messageService.create(userId, messageResponse);

    res.json([success, newMessage]);
  }

  static async findAll(
    {params: {userId}}: Request<{ userId: string }>,
    res: Response,
    next: any,
    serviceInjection: () => IMessageUseCase,
    tripServiceInjection: () => ITripUseCase,
    profileServiceInjection: () => IProfileUseCase
  ): Promise<void> {
    const messageService = serviceInjection();
    const profileService = profileServiceInjection();
    const tripService = tripServiceInjection();
    const messages = await messageService.findAll(userId);

    if (messages.length === 0) {
      const profile = await profileService.findOne(userId);
      if (!profile) return next(new ProfileNotFoundError());
      const trips = await tripService.findAll(userId);
      if (trips.length === 0) return next(new NoTripFoundError());
      const defaultMessage: IMessage = {
        isUser: false,
        message: "Ask me about any concerns for your upcoming trip!",
        userId: userId,
      };
      const newMessage = await messageService.create(userId, defaultMessage);
      messages.push(newMessage);
    }
    res.json(messages);
  }

  static async deleteAll(
    {params: {userId}}: Request<{ userId: string }>,
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
export function tripServiceInjection(): ITripUseCase {
  const tripDrivenAdapter = new TripDrivenAdapter();
  const tripService = new TripService(tripDrivenAdapter);
  return tripService;
}
export function profileServiceInjection(): IProfileUseCase {
  const profileDrivenAdapter = new ProfileDrivenAdapter();
  const profileService = new ProfileService(profileDrivenAdapter);
  return profileService;
}
