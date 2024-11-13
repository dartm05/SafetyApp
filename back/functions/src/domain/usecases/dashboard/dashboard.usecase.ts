import { IDashboard } from "../../models/dashboard/dashboard";

export interface IDashboardUseCase {
  findOne(userId: string): Promise<IDashboard | undefined>;
  create(
    userId: string,
    dashboard: IDashboard
  ): Promise<IDashboard | undefined>;
  delete(userId: string, id: string): Promise<IDashboard | undefined>;
}
