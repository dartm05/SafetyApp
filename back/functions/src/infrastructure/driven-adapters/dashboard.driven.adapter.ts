import {db} from "../../index";
import {IDashboard} from "../../domain/models/dashboard/dashboard";
import {IDashboardUseCase} from "../../domain/usecases/dashboard/dashboard.usecase";

export class DashboardDrivenAdapter implements IDashboardUseCase {
  async findOne(userId: string): Promise<IDashboard | undefined> {
    const querySnapshot = await db
      .collection("users")
      .doc(userId)
      .collection("dashboards")
      .get();

    if (querySnapshot.empty) {
      return undefined;
    }

    return querySnapshot.docs.map((doc) => {
      const data = doc.data() as IDashboard;
      return data;
    })[querySnapshot.docs.length - 1];
  }

  async create(
    userId: string,
    dashboard: IDashboard
  ): Promise<IDashboard | undefined> {
    const newDashboard = await db
      .collection("users")
      .doc(userId)
      .collection("dashboards")
      .add(dashboard);
    const newDate = new Date().toISOString();
    await newDashboard.update({
      id: newDashboard.id,
      timestamp: newDate,
    });
    return {
      ...dashboard,
      id: newDashboard.id,
      timestamp: newDate,
    } as IDashboard;
  }

  async delete(userId: string, id: string): Promise<IDashboard | undefined> {
    const querySnapshot = await db
      .collection("users")
      .doc(userId)
      .collection("dashboards")
      .doc(id)
      .get();

    if (!querySnapshot.exists) {
      return undefined;
    }
    const deleted = querySnapshot.data() as IDashboard;
    await db
      .collection("users")
      .doc(userId)
      .collection("dashboards")
      .doc(id)
      .delete();

    return deleted;
  }
}
