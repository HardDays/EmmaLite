import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class MeasurementPickerTop extends StatelessWidget {
  final String title;
  final Function completeTap;

  const MeasurementPickerTop({Key key, this.title, this.completeTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      width: MediaQuery
          .of(context)
          .size
          .width,
      color: AppColors.cFFFFFF,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 10.h,
                ),
                child: AppIcons.close(),
              ),
            ),
          ),
          Text(
            title,
            style: AppTypography.font16.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.c4A4A4A,
            ),
          ),
          Positioned(
            right: 0,
            child: GestureDetector(
              onTap: completeTap,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 10.h,
                ),
                child: AppIcons.accept(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
