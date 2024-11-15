import {Request, Response} from "express";
import {IDashboardUseCase} from "../../domain/usecases/dashboard/dashboard.usecase";
import {DashboardService} from "../../application/services/dashboard.service";
import {DashboardDrivenAdapter} from "../driven-adapters/dashboard.driven.adapter";
import {ITripUseCase} from "../../domain/usecases/trip/trip.usecase";
import {IProfileUseCase} from "../../domain/usecases/profile/profile.usecase";

import {NoTripFoundError} from "../../domain/errors/no-trip-found.error";
import {ProfileNotFoundError} from "../../domain/errors/profile-not-found.error";
import {predict} from "../driven-adapters/prediction.adapter";
import {ProfileService} from "../../application/services/profile.service";
import {TripService} from "../../application/services/trip.service";
import {ProfileDrivenAdapter} from "../driven-adapters/profile.driven.adapter";
import {TripDrivenAdapter} from "../driven-adapters/trip.driven.adappter";
import {formatSafetyRecommendations} from "../../utils/formatResponse";
import {IDashboard} from "../../domain/models/dashboard/dashboard";
import {DashboardNotFoundError} from "../../domain/errors/dashboard-not-found.error";

export class DashboardController {
  static async findOne(
    {params: {userId}}: Request<{ userId: string }>,
    res: Response,
    next: any,
    serviceInjection: () => IDashboardUseCase
  ): Promise<void> {
    const dashboardService = serviceInjection();
    const dashboard = await dashboardService.findOne(userId);
    res.json(dashboard);
  }

  static async create(
    {params: {userId}}: Request<{ userId: string }>,
    res: Response,
    next: any,
    serviceInjection: () => IDashboardUseCase,
    tripServiceInjection: () => ITripUseCase,
    profileServiceInjection: () => IProfileUseCase
  ): Promise<void> {
    const tripService = tripServiceInjection();
    const profileService = profileServiceInjection();
    const dashboardService = serviceInjection();

    const trips = await tripService.findAll(userId);

    if (trips.length === 0) return next(new NoTripFoundError());

    const trip = trips[trips.length - 1];

    const profile = await profileService.findOne(userId);

    if (!profile) return next(new ProfileNotFoundError());

    const prediction = await predict(trip, profile);
    const dashboardCards = formatSafetyRecommendations(prediction);

    const newDashboard: IDashboard = {
      userId,
      cards: dashboardCards,
      timestamp: new Date().toISOString(),
      title: "Your Trip to " + trip.destination,
      description:
        "Safety Recommendations for your trip to " + trip.destination,
    };
    const success = await dashboardService.create(userId, newDashboard);
    if (!success) return next(new NoTripFoundError());
    res.json(success);
  }

  static async delete(
    {params: {userId, id}}: Request<{ userId: string; id: string }>,
    res: Response,
    next: any,
    serviceInjection: () => IDashboardUseCase
  ): Promise<void> {
    const dashboardService = serviceInjection();
    const success = await dashboardService.delete(userId, id);
    if (!success) return next(new DashboardNotFoundError());
    res.json(success);
  }
}
export function dashboardServiceInjection(): IDashboardUseCase {
  return new DashboardService(new DashboardDrivenAdapter());
}
export function tripServiceInjection(): ITripUseCase {
  return new TripService(new TripDrivenAdapter());
}
export function profileServiceInjection(): IProfileUseCase {
  return new ProfileService(new ProfileDrivenAdapter());
}
