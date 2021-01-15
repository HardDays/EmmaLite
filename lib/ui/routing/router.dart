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

  Future<void> showErrorDialog(
    BuildContext context,
    String message, {
    String title = 'Ошибка',
    String actionText = 'Закрыть',
  }) {
    // requireNotNull(message);
    final buttonTextStyle = Theme.of(context).accentTextTheme.bodyText1;
    final routeSettings = RouteSettings(name: 'ErrorDialog:$message');
    if (Platform.isIOS) {
      return showCupertinoDialog(
        context: context,
        routeSettings: routeSettings,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(
              message,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  actionText,
                  style: buttonTextStyle,
                ),
              )
            ],
          );
        },
      );
    } else {
      return showDialog(
        context: context,
        routeSettings: routeSettings,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(
              message,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  actionText,
                  style: buttonTextStyle,
                ),
              )
            ],
          );
        },
      );
    }
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
