import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class MeasurementHorizontalListItem extends StatelessWidget {
  const MeasurementHorizontalListItem({this.item, Key key}) : super(key: key);

  final Measurement item;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cFFFFFF,
          borderRadius: BorderRadius.circular(4),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Text(
                item.title,
                style: AppTypography.font14.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.c3B4047,
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.value(),
                  style: AppTypography.font20.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.c3B4047,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: Text(
                    item.units,
                    style:
                        AppTypography.font12.copyWith(color: AppColors.c9B9B9B),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                item.getFormattedDate(),
                style: AppTypography.font10.copyWith(color: AppColors.c9B9B9B),
              ),
            )
          ],
        ),
      ),
    );
  }
}
