import 'package:emma_mobile/ui/components/bottom_sheet.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/measurement/default_container.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class DefaultPickerField extends StatelessWidget {
  final String title;
  final String hintText;
  final int index;
  final List<String> values;
  final Function(int index) onChange;

  const DefaultPickerField({
    Key key,
    this.title,
    this.index,
    this.values,
    this.hintText,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultContainer(
      onTap: () async {
        final res = await showDefaultPicker(
          context: context,
          pickerTitle: title,
          values: values,
        );
        if (res != null) {
          onChange?.call(res);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          children: [
            if (index != null)
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
                      values[index],
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
            AppIcons.arrowRight(),
          ],
        ),
      ),
    );
  }
}