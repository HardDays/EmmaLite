import 'package:flutter/material.dart';

class PageWidget {
  List<DayWidget> dayWidgets;
  Widget widget;

  PageWidget({this.dayWidgets, this.widget});
}

class DayWidget {
  int day;
  int startTask;
  int endTask;
  int startMeas;
  int endMeas;

  DayWidget({
    this.startTask,
    this.day,
    this.endTask,
    this.startMeas,
    this.endMeas,
  });
}

class WidgetReturn {
  Widget widget;
  int initDayIndex;
  int dayIndex;
  int initTaskIndex;
  int taskIndex;
  int initMeasIndex;
  int measIndex;

  WidgetReturn({
    this.widget,
    this.dayIndex = 0,
    this.taskIndex = 0,
    this.measIndex = 0,
    this.initTaskIndex = 0,
    this.initDayIndex = 0,
    this.initMeasIndex = 0,
  });

  WidgetReturn copy() => WidgetReturn(
    widget: widget,
    taskIndex: taskIndex,
    dayIndex: dayIndex,
    measIndex: measIndex,
    initTaskIndex: initTaskIndex,
    initMeasIndex: initMeasIndex,
    initDayIndex: initDayIndex,
  );
}