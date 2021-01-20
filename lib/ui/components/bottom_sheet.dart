import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/measurement/measurement.dart';
import 'package:emma_mobile/ui/components/pickers/date_picker.dart';
import 'package:emma_mobile/ui/routing/navigator.dart';
import 'package:emma_mobile/ui/styles/test_styles.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/cupertino.dart' hide CupertinoDatePicker;
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

Future<DateTime> showDateTimeModalBottom({
  BuildContext context,
  String pickerTitle,
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
              mode: CupertinoDatePickerMode.dateAndTime,
              initialDateTime: DateTime.now()
                ..subtract(
                  const Duration(minutes: 1),
                ),
              maximumDate: DateTime.now(),
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

List<Widget> _pickerWidgets({BuildContext context, int start, int max}) {
  final items = <Widget>[];

  for (var i = start; i <= max; i++) {
    items.add(
      Center(
        child: Text(
          i.toString(),
          style: CupertinoTheme.of(context).textTheme.dateTimePickerTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
  return items;
}
