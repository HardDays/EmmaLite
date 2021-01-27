import 'dart:io';

import 'package:dio/dio.dart';
import 'package:emma_mobile/models/time_enum.dart';
import 'package:emma_mobile/models/time_range.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/services.dart';
import 'package:image/image.dart';

class Static {
  static Static _instance;

  factory Static() {
    _instance ??= Static._internal();
    return _instance;
  }

  Static._internal();

  static Future<void> init() async {
    _instance ??= Static._internal();
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

  static Dio dio() {
    final baseClient = Dio(
      BaseOptions(baseUrl: ApiPath.baseUrl),
    );
    baseClient.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true),
    );
    return baseClient;
  }

  static MultipartFile resizeImage({@required String path}) {
    final image = decodeImage(File(path).readAsBytesSync());

    Image resizeImage;
    if (image.height > image.width) {
      resizeImage = copyResize(image, height: 640);
    } else {
      resizeImage = copyResize(image, width: 640);
    }
    return MultipartFile.fromBytes(
      encodePng(resizeImage),
      filename: '$path.jpg',
    );
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
          timeFrom: DateTime(
              roundDate.year, roundDate.month, roundDate.day, 0, 0, 0),
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
