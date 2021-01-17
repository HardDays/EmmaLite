import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/space.dart';
import 'package:emma_mobile/ui/screens/measurement/measurement_detail.dart';
import 'package:emma_mobile/ui/styles/test_styles.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class MeasurementListItem extends StatelessWidget {
  const MeasurementListItem({this.item});

  final Measurement item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) {
                return MeasurementDetailScreen();
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
              AppIcons.measurementDefault(width: 44, height: 44),
              const WSpace(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title,
                    style: CustomTextStyles.textFieldText,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    item.getDate(),
                    style: CustomTextStyles.inactiveGenderBlock
                        .copyWith(fontSize: 12),
                  )
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(item.value(), style: CustomTextStyles.introLogoTitle),
                  Text(
                    item.units,
                    style: CustomTextStyles.inactiveGenderBlock
                        .copyWith(fontSize: 12),
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
