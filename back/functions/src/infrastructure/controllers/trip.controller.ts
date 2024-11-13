import {Request, Response} from "express";
import {ITripUseCase} from "../../domain/usecases/trip/trip.usecase";
import {TripService} from "../../application/services/trip.service";
import {TripDrivenAdapter} from "../driven-adapters/trip.driven.adappter";

export class TripController {
  static async create(
    {params: {userId}, body}: Request<{ userId: string }>,
    res: Response,
    next: any,
    serviceInjection: () => ITripUseCase
  ): Promise<void> {
    const tripService = serviceInjection();
    const success = await tripService.create(userId, body);
    if (!success) return next(new Error());
    res.json(success);
  }

  static async findAll(
    {params: {userId}}: Request<{ userId: string }>,
    res: Response,
    next: any,
    serviceInjection: () => ITripUseCase
  ): Promise<void> {
    const tripService = serviceInjection();
    const trips = await tripService.findAll(userId);
    res.json(trips);
  }

  static async findOne(
    {params: {userId, id}}: Request<{ userId: string; id: string }>,
    res: Response,
    next: any,
    serviceInjection: () => ITripUseCase
  ): Promise<void> {
    const tripService = serviceInjection();
    const trip = await tripService.findOne(userId, id);
    if (!trip) return next(new Error());
    res.json(trip);
  }

  static async update(
    {params: {userId, id}, body}: Request<{ userId: string; id: string }>,
    res: Response,
    next: any,
    serviceInjection: () => ITripUseCase
  ): Promise<void> {
    const tripService = serviceInjection();
    const success = await tripService.update(userId, id, body);
    if (!success) return next(new Error());
    res.json(success);
  }

  static async remove(
    {params: {userId, id}}: Request<{ userId: string; id: string }>,
    res: Response,
    next: any,
    serviceInjection: () => ITripUseCase
  ): Promise<void> {
    const tripService = serviceInjection();
    const success = await tripService.remove(userId, id);
    if (!success) return next(new Error());
    res.json(success);
  }
}
export function serviceInjection(): ITripUseCase {
  const tripDrivenAdapter = new TripDrivenAdapter();
  const tripService = new TripService(tripDrivenAdapter);
  return tripService;
}
