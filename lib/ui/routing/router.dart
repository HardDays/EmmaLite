import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum RouterTab { graph, measurements, add, prescriptions, menu }

class AppRoutes {}

class AppRouter {
  AppRouter._();

  static AppRouter _instance;

  static AppRouter get current => _instance ??= AppRouter._();

  final tabController = CupertinoTabController();

  GlobalKey<NavigatorState> rootNavigatorKey;

  void openTab(RouterTab tab) {
    final index = RouterTab.values.indexOf(tab);
    tabController.index = index;
  }

  Future<void> showModalDialog(Widget child) {
    // requireNotNull(child);
    return showDialog(
      routeSettings:
          RouteSettings(name: 'ModalDialog:${child?.runtimeType?.toString()}'),
      context: rootNavigatorKey.currentContext,
      builder: (context) => child,
    );
  }
}
