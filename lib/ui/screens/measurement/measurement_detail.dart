import 'package:emma_mobile/bloc/measurement_detail_bloc/measurement_detail_bloc.dart';
import 'package:emma_mobile/bloc/measurement_detail_bloc/measurement_detail_state.dart';
import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/measurement_app_bar.dart';
import 'package:emma_mobile/ui/screens/measurement/measurement_history_screen.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeasurementDetailScreen extends StatelessWidget {
  final Measurement item;

  const MeasurementDetailScreen({
    @required this.item,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MeasurementDetailBloc(measurement: item),
      child: Scaffold(
        backgroundColor: AppColors.cF5F7FA,
        body: Builder(
          builder: (context) {
            final bloc = context.bloc<MeasurementDetailBloc>();
            return BlocBuilder<MeasurementDetailBloc, MeasurementDetailState>(
              builder: (_, __) {
                return Column(
                  children: [
                    MeasurementDetailAppBar(
                      title: item.longTitle,
                      initialType: bloc.type,
                      item: item,
                      onChange: bloc.setDateType,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 400.h,
                      color: AppColors.cFFFFFF,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          if (bloc.data.isEmpty)
                            Padding(
                              padding: EdgeInsets.only(
                                left: 11.w,
                                bottom: 16.h,
                              ),
                              child: Text(
                                'Нет данных',
                                style: AppTypography.font18.copyWith(
                                  color: AppColors.c9B9B9B,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )
                          else
                            Padding(
                              padding: EdgeInsets.only(
                                left: 11.w,
                                bottom: 16.h,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _ColumnItem(
                                      title: 'Мин.',
                                      subtitle: '',
                                    ),
                                  ),
                                  Expanded(
                                    child: _ColumnItem(
                                      title: 'Макс.',
                                      subtitle: '',
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ],
                      ),
                    ),
                    _History(),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _ColumnItem extends StatelessWidget {
  final String title;
  final String subtitle;

  const _ColumnItem({Key key, this.title, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.font14.copyWith(
            color: AppColors.c3B4047,
            fontWeight: FontWeight.w300,
          ),
        ),
        Text(
          subtitle,
          style: AppTypography.font17.copyWith(
            color: AppColors.c3B4047,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ColoredBox(
        color: AppColors.cF5F7FA,
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(
              top: 17.h,
              left: 16.w,
              right: 16.w,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      final bloc = context.bloc<MeasurementDetailBloc>();
                      return BlocProvider.value(
                        value: bloc,
                        child: MeasurementHistoryScreen(),
                      );
                    },
                  ),
                );
              },
              child: Container(
                width: 288.w,
                constraints: BoxConstraints(
                  minHeight: 46.h,
                ),
                color: AppColors.cFFFFFF,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 20.h,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'История измерений',
                        style: AppTypography.font16.copyWith(
                          color: AppColors.c3B4047,
                        ),
                      ),
                      const Spacer(),
                      AppIcons.arrowRight(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
