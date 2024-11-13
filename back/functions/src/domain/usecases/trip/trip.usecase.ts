import {ITrip} from "../../models/trip/trip";

export interface ITripUseCase {
  create(userId: string, trip: ITrip): Promise<ITrip | undefined>;
  findAll(userId: string): Promise<ITrip[]>;
  findOne(userId: string, id: string): Promise<ITrip | undefined>;
  update(userId: string, id: string, trip: ITrip): Promise<ITrip | undefined>;
  remove(userId: string, id: string): Promise<ITrip | undefined>;
}
