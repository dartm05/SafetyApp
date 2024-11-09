import { IProfile } from "../../models/profile/profile";

export interface IProfileUseCase {
  create(userId: string, profile: IProfile): Promise<IProfile | undefined>;
  findOne(userId: string, id: string): Promise<IProfile | undefined>;
  update(
    userId: string,
    id: string,
    profile: IProfile
  ): Promise<IProfile | undefined>;
}
