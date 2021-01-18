import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/ui/components/space.dart';
import 'package:emma_mobile/ui/styles/test_styles.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class MeasurementHorizontalListItem extends StatelessWidget {
  const MeasurementHorizontalListItem({this.item, Key key}) : super(key: key);

  final Measurement item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cFFFFFF,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(item.title, style: CustomTextStyles.textFieldText),
          const HSpace(8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item.value(),
                style: CustomTextStyles.pickerChildrenTitle
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              const WSpace(4),
              Text(
                item.units,
                style:
                    CustomTextStyles.inactiveGenderBlock.copyWith(fontSize: 12),
              )
            ],
          ),
          const HSpace(8),
          Text(
            item.getFormattedDate(),
            style: CustomTextStyles.inactiveGenderBlock.copyWith(fontSize: 10),
          )
        ],
      ),
    );
  }
}
