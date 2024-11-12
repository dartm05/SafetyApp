import { IDashboard } from "../../domain/models/dashboard/dashboard";
import { IDashboardUseCase } from "../../domain/usecases/dashboard/dashboard.usecase";

export class DashboardService implements IDashboardUseCase {
  constructor(private dashboardDrivenAdapter: IDashboardUseCase) {}

  findOne(userId: string): Promise<IDashboard | undefined> {
    return this.dashboardDrivenAdapter.findOne(userId);
  }

  create(
    userId: string,
    dashboard: IDashboard
  ): Promise<IDashboard | undefined> {
    return this.dashboardDrivenAdapter.create(userId, dashboard);
  }
}
