import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/routing/navigator.dart';
import 'package:emma_mobile/ui/styles/test_styles.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/cupertino.dart';
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

Future<T> showDataPicker<T>(BuildContext context, List<T> data,
    void Function(T) onItemChanged, String toolBarTitle) {
  onItemChanged?.call(data[0]);
  return showCupertinoModalPopup(
    context: context,
    builder: (context) => Material(
      child: SizedBox(
        height: 250,
        child: Column(
          children: [
            _buildToolBar(context, toolBarTitle),
            Expanded(
              child: CupertinoPicker(
                itemExtent: 30,
                backgroundColor: AppColors.cF5F7FA,
                onSelectedItemChanged: (value) {
                  onItemChanged?.call(data[value]);
                },
                children: data
                    .map(
                      (item) => Text(
                        item.toString(),
                        style: CustomTextStyles.pickerChildrenTitle,
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    ),
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
            onTap: () => Navigator.pop(context),
            child: AppIcons.close()),
        Text(title, style: CustomTextStyles.generalAppBarTitle),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: AppIcons.accept(),
        ),
      ],
    ),
  );
}
