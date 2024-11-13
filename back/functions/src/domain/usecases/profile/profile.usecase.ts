import {IProfile} from "../../models/profile/profile";

export interface IProfileUseCase {
  create(userId: string, profile: IProfile): Promise<IProfile | undefined>;
  findOne(userId: string): Promise<IProfile | undefined>;
  update(userId: string, profile: IProfile): Promise<IProfile | undefined>;
}
