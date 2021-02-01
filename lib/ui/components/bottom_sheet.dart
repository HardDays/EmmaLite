import 'package:emma_mobile/models/assignment/tasks.dart';
import 'package:emma_mobile/models/picker_time_range.dart';
import 'package:emma_mobile/ui/components/count_change_row.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/measurement/measurement.dart';
import 'package:emma_mobile/ui/components/pickers/date_picker.dart';
import 'package:emma_mobile/ui/components/pickers/picker.dart';
import 'package:emma_mobile/ui/routing/navigator.dart';
import 'package:emma_mobile/ui/styles/test_styles.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/cupertino.dart'
    hide CupertinoDatePicker, CupertinoPicker;
import 'package:flutter/material.dart';

PersistentBottomSheetController<T> showMainBottomSheet<T>(
    BuildContext context, Widget child,
    {bool useRootNavigator = false}) {
  return showBottomSheet(
    context: context,
    builder: (context) => child,
  );
}

Future<void> showError(BuildContext context, String message,
    {String title = 'Ошибка'}) {
  return showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => navigatorPop(context),
            child: const Text('Close'),
          )
        ],
      );
    },
  );
}

Future<void> showCustomDatePicker(BuildContext context,
    void Function(DateTime) onItemChanged, String toolBarTitle,
    {CupertinoDatePickerMode mode = CupertinoDatePickerMode.dateAndTime}) {
  onItemChanged?.call(DateTime.now());
  return showCupertinoModalPopup(
    context: context,
    builder: (context) => Material(
      child: SizedBox(
        height: 250,
        child: Column(
          children: [
            _buildToolBar(context, toolBarTitle),
            Expanded(
              child: CupertinoDatePicker(
                use24hFormat: true,
                mode: mode,
                backgroundColor: AppColors.cF5F7FA,
                initialDateTime: DateTime.now(),
                minimumDate: DateTime(1990, 1, 1),
                onDateTimeChanged: (date) => onItemChanged(date),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildToolBar(BuildContext context, String title, {double height = 44}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: height,
    color: AppColors.cFFFFFF,
    padding: const EdgeInsets.all(13),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
            onTap: () => Navigator.pop(context), child: AppIcons.close()),
        Text(title, style: CustomTextStyles.generalAppBarTitle),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: AppIcons.accept(),
        ),
      ],
    ),
  );
}

Future<TaskTime> showCustomTimePicker({
  BuildContext context,
  TaskTime time,
  PickerTimeRange timeRange,
  bool showCount = true,
  String title,
}) {
  final initialHour = time.time.hour - timeRange.minHour;
  final hour = _pickerWidgets(
    context: context,
    start: timeRange.minHour,
    max: timeRange.maxHour,
  );

  final minutes = _pickerWidgets(context: context, max: 59);

  return showModalBottomSheet(
    context: context,
    builder: (_) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MeasurementPickerTop(
            title: title,
            completeTap: () {
              Navigator.of(context).pop(time);
            },
          ),
          SizedBox(
            height: 199.h,
            child: Row(
              children: [
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 40.h,
                    scrollController: FixedExtentScrollController(
                      initialItem: initialHour ?? 0,
                    ),
                    onSelectedItemChanged: (i) {
                      time = time.copyWith(
                        time: Time(
                          hour: i + timeRange.minHour,
                          minutes: time.time.minutes,
                        ),
                      );
                    },
                    backgroundColor: AppColors.cF5F7FA,
                    useMagnifier: true,
                    children: hour,
                  ),
                ),
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 40.h,
                    scrollController: FixedExtentScrollController(
                      initialItem: time.time.minutes ?? 0,
                    ),
                    onSelectedItemChanged: (i) {
                      time = time.copyWith(
                        time: Time(hour: time.time.hour, minutes: i),
                      );
                    },
                    backgroundColor: AppColors.cF5F7FA,
                    useMagnifier: true,
                    children: minutes,
                  ),
                ),
              ],
            ),
          ),
          if (showCount)
            CountChangeRow(
              initialValue: time.count,
              onChange: (v) {
                time = time.copyWith(count: v);
              },
            )
        ],
      );
    },
  );
}

Future<int> showDefaultPicker({
  BuildContext context,
  String pickerTitle,
  List<String> values,
}) {
  int index = 0;
  final children = _pickerWidgets(
    context: context,
    max: values.length,
    values: values,
  );

  return showModalBottomSheet(
    context: context,
    builder: (_) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MeasurementPickerTop(
            title: pickerTitle,
            completeTap: () {
              Navigator.of(context).pop(index);
            },
          ),
          SizedBox(
            height: 199.h,
            child: CupertinoPicker(
              itemExtent: 40.h,
              onSelectedItemChanged: (i) {
                index = i;
              },
              backgroundColor: AppColors.cF5F7FA,
              useMagnifier: true,
              children: children,
            ),
          ),
        ],
      );
    },
  );
}

Future<DateTime> showDateTimeModalBottom({
  BuildContext context,
  String pickerTitle,
  DateTime minimumDate,
  DateTime maximumDate,
}) {
  return showModalBottomSheet(
    context: context,
    builder: (_) {
      DateTime dateTime;
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MeasurementPickerTop(
            title: pickerTitle,
            completeTap: () {
              Navigator.of(context).pop(dateTime ?? DateTime.now());
            },
          ),
          SizedBox(
            height: 199.h,
            child: CupertinoDatePicker(
              onDateTimeChanged: (value) {
                dateTime = value;
              },
              use24hFormat: true,
              minimumDate: minimumDate,
              mode: CupertinoDatePickerMode.dateAndTime,
              initialDateTime: DateTime.now()
                ..subtract(
                  const Duration(minutes: 1),
                ),
              maximumDate: maximumDate,
              backgroundColor: AppColors.cF5F7FA,
            ),
          ),
        ],
      );
    },
  );
}

Future<double> showDoublePicker({
  BuildContext context,
  String title,
  int firstIndex,
  int firstMaxValue,
  int firstStartValue,
  int secondIndex,
  int secondMaxValue,
  int secondStartValue,
}) async {
  int firstValue = firstIndex;
  int secondValue = secondIndex;
  final firstItems = _pickerWidgets(
    context: context,
    start: firstStartValue,
    max: firstMaxValue,
  );
  final secondItems = _pickerWidgets(
    context: context,
    start: secondStartValue,
    max: secondMaxValue,
  );

  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MeasurementPickerTop(
            title: title,
            completeTap: () {
              final start = firstStartValue + firstValue;
              final end = secondStartValue + secondValue;
              final value = start + end / 10;
              Navigator.of(context).pop(value);
            },
          ),
          SizedBox(
            height: 199.h,
            child: Row(
              children: [
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 30.h,
                    useMagnifier: true,
                    scrollController:
                        FixedExtentScrollController(initialItem: firstValue),
                    onSelectedItemChanged: (i) {
                      firstValue = i;
                    },
                    children: firstItems,
                  ),
                ),
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 30.h,
                    useMagnifier: true,
                    scrollController:
                        FixedExtentScrollController(initialItem: secondValue),
                    onSelectedItemChanged: (i) {
                      secondValue = i;
                    },
                    children: secondItems,
                  ),
                ),
              ],
            ),
          )
        ],
      );
    },
  );
}

List<Widget> _pickerWidgets({
  BuildContext context,
  int start = 0,
  int max,
  List<String> values,
}) {
  final items = <Widget>[];

  for (var i = start; i <= max; i++) {
    if (values != null && i >= values.length) {
      break;
    }
    items.add(
      Center(
        child: Text(
          values == null ? i.toString() : values[i],
          style: CupertinoTheme.of(context).textTheme.dateTimePickerTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
  return items;
}
