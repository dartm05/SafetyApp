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

  DashboardProvider({required this.dashboardUsecase});

  Future<void> initializeDashboard() async {
    isLoading = true;
    notifyListeners();
    if (_dashboard == null) {
      await createDashboard();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> createDashboard() async {
    isLoading = true;
    notifyListeners();
    await dashboardUsecase.createDashboard();
    Dashboard? dashboard = await dashboardUsecase.getDashboard();
    if (dashboard != null) {
      _dashboard = dashboard;
      _cards = dashboard.cards;
    }
    isLoading = false;
    notifyListeners();
  }

  void updateDashboard(Dashboard? dashboard) {
    _dashboard = dashboard;
    _cards = dashboard?.cards ?? [];
    notifyListeners();
  }

  Future<void> deleteDashboard() async {
    isLoading = true;
    notifyListeners();
    await dashboardUsecase.deleteDashboard(_dashboard!.id!);
    _dashboard = null;
    _cards = [];
    isLoading = false;
    notifyListeners();
  }
}
