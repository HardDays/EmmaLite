import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/screens/measurement/measurement_detail.dart';
import 'package:emma_mobile/ui/screens/measurement/measurement_new.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class MeasurementListItem extends StatelessWidget {
  const MeasurementListItem({this.item, this.isSelectScreen = false});

  final Measurement item;
  final bool isSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) {
                return isSelectScreen
                    ? MeasurementNewScreen(item: item)
                    : MeasurementDetailScreen(item: item);
              },
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            color: AppColors.cFFFFFF,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: AppIcons.measurementDefault(width: 44, height: 44),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.longTitle,
                    style: AppTypography.font16.copyWith(
                      color: AppColors.c3B4047,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    isSelectScreen
                        ? item.units
                        : item.getFormattedDate(showTimeIfToday: true),
                    style: AppTypography.font12.copyWith(
                      color: AppColors.c9B9B9B,
                    ),
                  )
                ],
              ),
              const Spacer(),
              if (!isSelectScreen)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.value(),
                      style: AppTypography.font16.copyWith(
                        color: AppColors.c3B4047,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      item.units,
                      style: AppTypography.font12
                          .copyWith(color: AppColors.c9B9B9B),
                    )
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
