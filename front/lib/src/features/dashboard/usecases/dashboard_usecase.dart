import 'package:safety_app/src/core/providers/auth_provider.dart';
import 'package:safety_app/src/data/models/dashboard.dart';

import '../services/dashboard_service.dart';

enum DashboardPrompt { TRIP, CHAT, PROFILE }

class DashboardUsecase {
  final DashboardService dashboardService;
  final AuthenticationProvider authenticationProvider;

  DashboardUsecase(
      {required this.dashboardService, required this.authenticationProvider});

  Future<Dashboard?> getDashboard() async {
    return await dashboardService.getDashboard(authenticationProvider.userId!);
  }
  Future<void> createDashboard() async {
    return await dashboardService.createDashboard(authenticationProvider.userId!);
  }
}
