import 'package:emma_mobile/generated/assets.gen.dart';
import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/ui/components/space.dart';
import 'package:emma_mobile/ui/routing/navigator.dart';
import 'package:emma_mobile/ui/screens/measurement/measurement_new.dart';
import 'package:emma_mobile/ui/styles/test_styles.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class EmptyMeasurements extends StatelessWidget {
  const EmptyMeasurements({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const HSpace(72),
          _buildIconBlock(context),
          const HSpace(24),
          Text(
            // ignore: lines_longer_than_80_chars
            'Здесь будут показываться ваши последние значения по всем измерениям',
            style: CustomTextStyles.introLogoSubtitle
                .copyWith(color: AppColors.c9B9B9B),
            textAlign: TextAlign.center,
          ),
          const HSpace(55),
          EmmaFilledButton(
            title: 'Добавить первое измерение',
            onTap: () => navigatorPush(context, MeasurementNewScreen()),
          )
        ],
      ),
    );
  }

  Widget _buildIconBlock(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.cFFFFFF,
        boxShadow: [
          BoxShadow(
            color: AppColors.black12,
            offset: Offset(0, 3),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.only(top: 40, right: 38, left: 38, bottom: 36),
      child: Assets.icons.measurementsInactive.svg(width: 44, height: 44),
    );
  }
}
