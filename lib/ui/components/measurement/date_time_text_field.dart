import 'package:emma_mobile/ui/components/bottom_sheet.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/measurement/default_container.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DateTimeTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final DateTime value;
  final DateFormat dateFormat;
  final Function(DateTime time) onChange;
  final bool haveDecoration;
  final DateTime minimumDate;
  final DateTime initialDate;
  final DateTime maximumDate;
  final bool nowMaximum;
  final bool nowMinimum;
  final bool enable;
  final Color color;
  final CupertinoDatePickerMode mode;

  const DateTimeTextField({
    Key key,
    this.title,
    this.value,
    this.hintText,
    this.onChange,
    this.dateFormat,
    this.haveDecoration = true,
    this.minimumDate,
    this.initialDate,
    this.maximumDate,
    this.enable = true,
    this.color,
    this.mode = CupertinoDatePickerMode.dateAndTime,
    this.nowMaximum = false,
    this.nowMinimum = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final format = dateFormat ?? DateFormat('dd MMMM yyyy, HH:mm');
    return DefaultContainer(
      color: color,
      onTap: () async {
        if (!enable) {
          return;
        }
        final now = DateTime.now();
        DateTime maxDateTime = maximumDate;
        DateTime minDateTime = minimumDate;
        DateTime initDateTime = initialDate;
        if (nowMaximum) {
          maxDateTime = now;
        }
        if (nowMinimum) {
          minDateTime = now;
          if (initialDate != null && initialDate.isBefore(minDateTime)) {
            initDateTime = now;
          }
          // minDateTime = minDateTime.subtract(Duration(minutes: 2));

        }
        final res = await showDateTimeModalBottom(
          context: context,
          pickerTitle: title,
          initialDate: initDateTime ?? now,
          minimumDate: minDateTime,
          maximumDate: maxDateTime,
          mode: mode,
        );
        if (res != null) {
          onChange?.call(res);
        }
      },
      haveDecoration: haveDecoration,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          children: [
            if (value != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.font12.copyWith(
                      color: AppColors.c9B9B9B,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Text(
                      format.format(value),
                      style: AppTypography.font16.copyWith(
                        color: AppColors.c4A4A4A,
                      ),
                    ),
                  )
                ],
              )
            else
              Text(
                hintText,
                style: AppTypography.font14.copyWith(
                  color: AppColors.c9B9B9B,
                ),
              ),
            const Spacer(),
            if (enable) AppIcons.arrowRight(),
          ],
        ),
      ),
    );
  }
}
