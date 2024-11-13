import 'package:flutter/material.dart';
import 'package:safety_app/src/data/models/dashboard.dart';
import 'package:safety_app/src/data/models/dashboard_card.dart';
import 'package:safety_app/src/features/dashboard/usecases/dashboard_usecase.dart';

class DashboardProvider extends ChangeNotifier {
  List<DashboardCard> _cards = [];
  Dashboard? _dashboard;
  bool isLoading = false;

  List<DashboardCard> get cards => _cards;
  Dashboard? get dashboard => _dashboard;

  final DashboardUsecase dashboardUsecase;

  DashboardProvider({required this.dashboardUsecase}) ;

  Future<void> initializeDashboard() async {
    isLoading = true;
    notifyListeners();
    Dashboard? dashboard = await dashboardUsecase.getDashboard();
    if (dashboard == null) {
      await dashboardUsecase.createDashboard();
      dashboard = await dashboardUsecase.getDashboard();
    } else {
      _dashboard = dashboard;
      _cards = dashboard.cards;
    }
    isLoading = false;
    notifyListeners();
  }
}
