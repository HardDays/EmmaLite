import 'package:emma_mobile/ui/components/bottom_sheet.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/measurement/default_container.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final DateTime value;
  final DateFormat dateFormat;
  final Function(DateTime time) onChange;
  final bool haveDecoration;
  final DateTime minimumDate;
  final DateTime maximumDate;
  final bool enable;
  final Color color;

  const DateTimeTextField({
    Key key,
    this.title,
    this.value,
    this.hintText,
    this.onChange,
    this.dateFormat,
    this.haveDecoration = true,
    this.minimumDate,
    this.maximumDate,
    this.enable = true,
    this.color,
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
        final res = await showDateTimeModalBottom(
          context: context,
          pickerTitle: title,
          minimumDate: minimumDate,
          maximumDate: maximumDate,
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
                  color: AppColors.cA7AFB8,
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
