import { IProfile } from "../../domain/models/profile/profile";
import { IProfileUseCase } from "../../domain/usecases/profile/profile.usecase";

export class ProfileService implements IProfileUseCase {
  constructor(private profileDrivenAdapter: IProfileUseCase) {}

  create(userId: string, profile: IProfile): Promise<IProfile | undefined> {
    return this.profileDrivenAdapter.create(userId, profile);
  }

  findOne(userId: string, id: string): Promise<IProfile | undefined> {
    return this.profileDrivenAdapter.findOne(userId, id);
  }

  update(
    userId: string,
    id: string,
    profile: IProfile
  ): Promise<IProfile | undefined> {
    return this.profileDrivenAdapter.update(userId, id, profile);
  }
}
