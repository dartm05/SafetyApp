import { db } from "../../index";
import { ITripUseCase } from "../../domain/usecases/trip/trip.usecase";
import { ITrip } from "../../domain/models/trip/trip";

export class TripDrivenAdapter implements ITripUseCase {
  async create(userId: string, trip: ITrip): Promise<ITrip | undefined> {
    const newTrip = await db
      .collection("users")
      .doc(userId)
      .collection("trips")
      .add(trip);

    const newDate = new Date().toISOString();
    await newTrip.update({
      id: newTrip.id,
      timestamp: newDate,
    });

    return { ...trip, id: newTrip.id, createdAt: newDate } as ITrip;
  }

  async findAll(userId: string): Promise<ITrip[]> {
    const querySnapshot = await db
      .collection("users")
      .doc(userId)
      .collection("trips")
      .get();
      const trips: ITrip[] = querySnapshot.docs.map(doc => ({
        ...doc.data(),
        id: doc.id
      })) as ITrip[];

      return trips.sort((a, b) => {
        return (
          new Date(b.createdAt).getTime() -
          new Date(a.createdAt).getTime()
        );
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
