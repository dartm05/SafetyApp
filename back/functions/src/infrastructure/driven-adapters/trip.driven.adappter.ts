import { db } from "../../index";
import { ITripUseCase } from "../../domain/usecases/trip/trip.usecase";
import { ITrip } from "../../domain/models/trip/trip";


export class TripDrivenAdapter implements ITripUseCase {
  async create(userId: string, trip: ITrip): Promise<ITrip | undefined> {
    const newTrip = await db
      .collection("users")
      .doc(userId)
      .collection("trips")
      .add(trip)
      .then((docRef) => {
        return { ...trip, id: docRef.id };
      });
    return newTrip;
  }

  async findAll(userId: string): Promise<ITrip[]> {
    const querySnapshot = await db
      .collection("users")
      .doc(userId)
      .collection("trips")
      .get();
    return querySnapshot.docs.map((doc) => {
      return { ...doc.data(), id: doc.id } as ITrip;
    });
  }

  async findOne(userId: string, id: string): Promise<ITrip | undefined> {
    const querySnapshot = await db
      .collection("users")
      .doc(userId)
      .collection("trips")
      .doc(id)
      .get();
    return { ...querySnapshot.data(), id } as ITrip;
  }

  async update(
    userId: string,
    id: string,
    trip: ITrip
  ): Promise<ITrip | undefined> {
    const updated = await db
      .collection("users")
      .doc(userId)
      .collection("trips")
      .doc(id)
      .update({ ...trip })
      .then(() => {
        return trip;
      });
    return updated as ITrip;
  }

  async remove(userId: string, id: string): Promise<ITrip | undefined> {
    const querySnapshot = await db
      .collection("users")
      .doc(userId)
      .collection("trips")
      .doc(id)
      .get();
    const trip = { ...querySnapshot.data(), id: querySnapshot.id } as ITrip;
    await querySnapshot.ref.delete();
    return trip;
  }
}