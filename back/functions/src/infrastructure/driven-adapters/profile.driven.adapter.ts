import { IProfile } from "../../domain/models/profile/profile";
import { IProfileUseCase } from "../../domain/usecases/profile/profile.usecase";
import { db } from "../../index";

export class ProfileDrivenAdapter implements IProfileUseCase {
  async create(
    userId: string,
    profile: IProfile
  ): Promise<IProfile | undefined> {
    const newProfile = await db
      .collection("users")
      .doc(userId)
      .collection("profile")
      .add(profile)
      .then((docRef) => {
        return { ...profile, id: docRef.id };
      });
    return newProfile;
  }

  async findOne(userId: string, id: string): Promise<IProfile | undefined> {
    const querySnapshot = await db
      .collection("users")
      .doc(userId)
      .collection("profile")
      .doc(id)
      .get();
    return { ...querySnapshot.data(), id } as IProfile;
  }

  async update(
    userId: string,
    id: string,
    profile: IProfile
  ): Promise<IProfile | undefined> {
    const updated = await db
      .collection("users")
      .doc(userId)
      .collection("profile")
      .doc(id)
      .update({ ...profile })
      .then(() => {
        return profile;
      });
    return updated as IProfile;
  }
}
