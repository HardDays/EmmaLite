import 'package:emma_mobile/models/assignment/tasks.dart';
import 'package:emma_mobile/models/time_enum.dart';
import 'package:emma_mobile/models/time_range.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Static {
  static Static _instance;

  factory Static() {
    _instance ??= Static._internal();
    return _instance;
  }

  static FlutterLocalNotificationsPlugin _notificationsPlugin;

  Static._internal();

  static Future<void> init() async {
    _instance ??= Static._internal();
    _notificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();
    const MacOSInitializationSettings initializationSettingsMacOS =
        MacOSInitializationSettings();
    const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        macOS: initializationSettingsMacOS);
    await _notificationsPlugin.initialize(initializationSettings);

    tz.initializeTimeZones();
  }

  static void addNotification({RunTask task, String title, String subtitle}) {
    final time = tz.TZDateTime.from(task.dateTime, tz.local);
    if (time.isBefore(DateTime.now())) {
      return;
    }
    _notificationsPlugin.zonedSchedule(
      task.id,
      title,
      subtitle,
      tz.TZDateTime.from(task.dateTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id',
          'Название',
          'Описание',
        ),
      ),
      uiLocalNotificationDateInterpretation: null,
      androidAllowWhileIdle: true,
    );
  }

  static void removeAllNotification() {
    _notificationsPlugin.cancelAll();
  }

  static void removeNotification({RunTask task}) {
    _notificationsPlugin.cancel(task.id);
  }

  static void lightStatusBarTheme() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ));
  }

  static void darkStatusBarTheme() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  static List<TimeRange> getTimeRange({DateTimeType type}) {
    var times = <TimeRange>[];
    var date = DateTime.now();
    if (type is HourDateTime) {
      date = date.add(const Duration(hours: 1));
      for (var i = 0; i < date.hour + 1; i++) {
        times.add(
          TimeRange(
            type: type,
            timeFrom: DateTime(date.year, date.month, date.day, i),
            timeTo: DateTime(date.year, date.month, date.day, i + 1),
          ),
        );
      }
      times = times.reversed.toList();
    } else if (type is DayDateTime) {
      var roundDate = date;
      final currentDay = date.day;
      final prevMonth = DateTime(date.year, date.month, 0).month;
      while (roundDate.day != currentDay || roundDate.month != prevMonth) {
        times.add(
          TimeRange(
            type: type,
            timeFrom: DateTime(
                roundDate.year, roundDate.month, roundDate.day, 0, 0, 0),
            timeTo: DateTime(
                roundDate.year, roundDate.month, roundDate.day, 23, 59, 59),
          ),
        );
        roundDate = roundDate.subtract(const Duration(days: 1));
      }
      times.add(
        TimeRange(
          type: type,
          timeFrom:
              DateTime(roundDate.year, roundDate.month, roundDate.day, 0, 0, 0),
          timeTo: DateTime(
              roundDate.year, roundDate.month, roundDate.day, 23, 59, 59),
        ),
      );
    } else if (type is WeekDateTime) {
      var roundDate = date;
      roundDate = roundDate.add(const Duration(hours: 3));
      while (roundDate.isAfter(DateTime(date.year - 1, date.month, date.day))) {
        times.add(
          TimeRange(
            type: type,
            timeFrom: DateTime(
                    roundDate.year, roundDate.month, roundDate.day, 0, 0, 0)
                .subtract(const Duration(days: 7)),
            timeTo: DateTime(
              roundDate.year,
              roundDate.month,
              roundDate.day,
              23,
              59,
              59,
            ),
          ),
        );
        roundDate = roundDate.subtract(const Duration(days: 8));
      }
    } else if (type is MonthDateTime) {
      for (var i = 0; i <= 12; i++) {
        times.add(
          TimeRange(
            type: type,
            timeFrom: DateTime(date.year, date.month - i, 1, 0, 0, 0),
            timeTo: DateTime(date.year, date.month - i + 1, 0, 0, 0, 0).add(
              const Duration(hours: 23, minutes: 59, seconds: 59),
            ),
          ),
        );
      }
    } else if (type is YearDateTime) {
      for (var i = 0; i < 2; i++) {
        times.add(
          TimeRange(
            type: type,
            timeFrom: DateTime(date.year - i, 1, 1, 0, 0, 0),
            timeTo: DateTime(date.year - i, 12, 31, 23, 59, 59),
          ),
        );
      }
    }
    return times;
  }
}
