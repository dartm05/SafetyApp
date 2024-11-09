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

  async findOne(userId: string): Promise<IProfile | undefined> {
    const querySnapshot = await db
      .collection("users")
      .doc(userId)
      .collection("profile")
      .get();
    return querySnapshot.docs.map((doc) => {
      const data = doc.data();
      return { ...data, id: doc.id } as IProfile;
    })[0];
  }

  async update(
    userId: string,
    profile: IProfile
  ): Promise<IProfile | undefined> {
    const profileCollection = db
      .collection("users")
      .doc(userId)
      .collection("profile");

    const querySnapshot = await profileCollection.get();
    const doc = querySnapshot.docs[0];

    if (doc) {
      await doc.ref.update({ ...profile });
      return { ...profile, id: doc.id } as IProfile;
    } else {
      throw new Error("Profile not found");
    }
  }
}
