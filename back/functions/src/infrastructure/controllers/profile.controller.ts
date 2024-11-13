import { Request, Response } from "express";
import { IProfileUseCase } from "../../domain/usecases/profile/profile.usecase";
import { ProfileService } from "../../application/services/profile.service";
import { ProfileDrivenAdapter } from "../driven-adapters/profile.driven.adapter";
import { ProfileNotCreatedError } from "../../domain/errors/profile-not-created.error";
import { ProfileNotFoundError } from "../../domain/errors/profile-not-found.error";
import { ProfileNotUpdatedError } from "../../domain/errors/profile-not-updated.error";

export class ProfileController {
  static async create(
    { params: { userId }, body }: Request<{ userId: string }>,
    res: Response,
    next: any,
    serviceInjection: () => IProfileUseCase
  ): Promise<void> {
    const profileService = serviceInjection();
    const success = await profileService.create(userId, body);
    if (!success) return next(new ProfileNotCreatedError());
    res.json(success);
  }

  static async findOne(
    { params: { userId } }: Request<{ userId: string }>,
    res: Response,
    next: any,
    serviceInjection: () => IProfileUseCase
  ): Promise<void> {
    const profileService = serviceInjection();
    const profile = await profileService.findOne(userId);
    if (!profile) return next(new ProfileNotFoundError());
    res.json(profile);
  }

  static async update(
    { params: { userId }, body }: Request<{ userId: string }>,
    res: Response,
    next: any,
    serviceInjection: () => IProfileUseCase
  ): Promise<void> {
    const profileService = serviceInjection();
    const success = await profileService.update(userId, body);
    if (!success) return next(new ProfileNotUpdatedError());
    res.json(success);
  }
}
export function serviceInjection(): IProfileUseCase {
  const profileDrivenAdapter = new ProfileDrivenAdapter();
  const profileService = new ProfileService(profileDrivenAdapter);
  return profileService;
}
