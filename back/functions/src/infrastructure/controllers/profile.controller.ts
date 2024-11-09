import { Request, Response } from "express";
import { IProfileUseCase } from "../../domain/usecases/profile/profile.usecase";
import { ProfileService } from  "../../application/services/profile.service";
import { ProfileDrivenAdapter } from "../driven-adapters/profile.driven.adapter";
import { ProfileNotCreatedError } from "../../domain/errors/profile-not-created";
import { ProfileNotFoundError } from "../../domain/errors/profile-not-found";
import { ProfileNotUpdatedError } from "../../domain/errors/profile-not-updated";


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
    { params: { userId, id } }: Request<{ userId: string; id: string }>,
    res: Response,
    next: any,
    serviceInjection: () => IProfileUseCase
  ): Promise<void> {
    const profileService = serviceInjection();
    const profile = await profileService.findOne(userId, id);
    if (!profile) return next(new ProfileNotFoundError());
    res.json(profile);
  }

  static async update(
    { params: { userId, id }, body }: Request<{ userId: string; id: string }>,
    res: Response,
    next: any,
    serviceInjection: () => IProfileUseCase
  ): Promise<void> {
    const profileService = serviceInjection();
    const success = await profileService.update(userId, id, body);
    if (!success) return next(new ProfileNotUpdatedError());
    res.json(success);
  }
}
export function serviceInjection(): IProfileUseCase {
    const profileDrivenAdapter = new ProfileDrivenAdapter();
    const profileService = new ProfileService(profileDrivenAdapter);
    return profileService;
  }
