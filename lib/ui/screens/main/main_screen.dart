import 'package:emma_mobile/bloc/main/main_cubit.dart';
import 'package:emma_mobile/bloc/main/main_state.dart';
import 'package:emma_mobile/domain/model/measurements/measurement.dart';
import 'package:emma_mobile/generated/assets.gen.dart';
import 'package:emma_mobile/ui/components/space.dart';
import 'package:emma_mobile/ui/routing/navigator.dart';
import 'package:emma_mobile/ui/screens/main/empty_block.dart';
import 'package:emma_mobile/ui/screens/main/measurement_horizontal_list_item.dart';
import 'package:emma_mobile/ui/screens/measurement/measurement_new.dart';
import 'package:emma_mobile/ui/styles/test_styles.dart';
import 'package:emma_mobile/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: HSpace(25)),
              SliverToBoxAdapter(
                child: Text(
                  greetingStringBasedOn(DateTime.now()),
                  style: CustomTextStyles.keypadItem,
                ),
              ),
              const SliverToBoxAdapter(child: HSpace(16)),
              const SliverToBoxAdapter(
                child: Text(
                  'Ваши ближайшие назначения',
                  style: CustomTextStyles.textFieldText,
                ),
              ),
              const SliverToBoxAdapter(child: HSpace(12)),
              SliverToBoxAdapter(
                child: EmptyBlockMain(
                  icon: Assets.icons.prescriptionsInactive.svg(),
                  title: 'Здесь будут показываться ваши ближайшие назначения',
                  buttonTitle: 'Добавить первое назначение',
                  onTap: () => print('Was called'),
                ),
              ),
              const SliverToBoxAdapter(child: HSpace(24)),
              const SliverToBoxAdapter(
                child: Text(
                  'Текущие измерения',
                  style: CustomTextStyles.textFieldText,
                ),
              ),
              const SliverToBoxAdapter(child: HSpace(12)),
              state.measurementList?.payload?.isNotEmpty == true
                  ? _buildMeasureList(context, state?.measurementList?.payload)
                  : SliverToBoxAdapter(
                      child: EmptyBlockMain(
                        icon: Assets.icons.measurementsInactive.svg(),
                        title:
                            // ignore: lines_longer_than_80_chars
                            'Здесь будут показываться ваши последние значения по всем измерениям',
                        buttonTitle: 'Добавить первое измерение',
                        onTap: () =>
                            navigatorPush(context, MeasurementNewScreen()),
                      ),
                    ),
              const SliverToBoxAdapter(child: HSpace(16)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMeasureList(
      BuildContext context, Iterable<Measurement> measures) {
    return SliverToBoxAdapter(
      child: Container(
        constraints: const BoxConstraints(minHeight: 50, maxHeight: 100),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => MeasurementHorizontalListItem(
            measures.elementAt(index),
          ),
          separatorBuilder: (context, index) => const WSpace(8),
          itemCount: measures.length,
        ),
      ),
    );
  }
}
