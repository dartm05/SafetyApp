import { ITrip } from "../../domain/models/trip/trip";
import { ITripUseCase } from "../../domain/usecases/trip/trip.usecase";

export class TripService implements ITripUseCase {
  constructor(private tripDrivenAdapter: ITripUseCase) {}

  create(userId: string, trip: ITrip): Promise<ITrip | undefined> {
    return this.tripDrivenAdapter.create(userId, trip);
  }

  findAll(userId: string): Promise<ITrip[]> {
    return this.tripDrivenAdapter.findAll(userId);
  }

  findOne(userId: string, id: string): Promise<ITrip | undefined> {
    return this.tripDrivenAdapter.findOne(userId, id);
  }

  update(userId: string, id: string, trip: ITrip): Promise<ITrip | undefined> {
    return this.tripDrivenAdapter.update(userId, id, trip);
  }

  remove(userId: string, id: string): Promise<ITrip | undefined> {
    return this.tripDrivenAdapter.remove(userId, id);
  }
}