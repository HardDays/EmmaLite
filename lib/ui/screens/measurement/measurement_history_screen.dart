import 'package:bot_toast/bot_toast.dart';
import 'package:emma_mobile/bloc/measurement/measurement_cubit.dart';
import 'package:emma_mobile/bloc/measurement_detail_bloc/measurement_detail_bloc.dart';
import 'package:emma_mobile/bloc/measurement_detail_bloc/measurement_detail_state.dart';
import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/models/measurements/pulse.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/measurement_app_bar.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class MeasurementHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _slidableController = SlidableController();
    final bloc = context.bloc<MeasurementDetailBloc>();
    return Provider.value(
      value: _slidableController,
      child: Scaffold(
        backgroundColor: AppColors.cF5F7FA,
        body: BlocBuilder<MeasurementDetailBloc, MeasurementDetailState>(
            builder: (_, state) {
          return Column(
            children: [
              MeasurementDetailAppBar(
                title: 'История измерений',
                arrowText: bloc.item.title,
                initialType: bloc.type,
                item: bloc.item,
                onChange: bloc.setDateType,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: bloc.data.length,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  itemBuilder: (_, i) {
                    return _Item(measurement: bloc.data[i]);
                  },
                  separatorBuilder: (_, __) {
                    return Padding(
                      padding: EdgeInsets.only(top: 8.h),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final Measurement measurement;

  const _Item({Key key, this.measurement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(measurement.dateTime.toString()),
      actionPane: const SlidableScrollActionPane(),
      controller: Provider.of<SlidableController>(context),
      actionExtentRatio: 0.25,
      secondaryActions: [
        GestureDetector(
          onTap: () {
            final mainBloc = context.bloc<MeasurementCubit>();
            final detailBloc = context.bloc<MeasurementDetailBloc>();
            mainBloc.deleteItem(
              measurement: measurement,
              index: detailBloc.data
                  .lastIndexWhere((e) => e.dateTime == measurement.dateTime),
            );
            detailBloc.deleteItem(measurement: measurement);
            BotToast.showText(
              text: 'Запись удалена',
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 8.h,
              ),
              contentColor: AppColors.c000000.withOpacity(0.8),
              textStyle: AppTypography.font14.copyWith(
                color: AppColors.cFFFFFF,
              ),
            );
          },
          child: ColoredBox(
            color: AppColors.cFF3B30,
            child: Center(
              child: AppIcons.trash(),
            ),
          ),
        ),
      ],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Container(
          constraints: BoxConstraints(minHeight: 68.h, maxHeight: 69.h),
          color: AppColors.cFFFFFF,
          child: Padding(
            padding: EdgeInsets.only(top: 12.h, bottom: 12.h, left: 16.w),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: AppIcons.measurementDefault(
                    width: 44.h,
                    height: 44.h,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              '${measurement.value()} ${measurement.units}',
                              style: AppTypography.font16.copyWith(
                                color: AppColors.c3B4047,
                              ),
                            ),
                            const Spacer(),
                            if (measurement is Pulse) ...[
                              Padding(
                                padding: EdgeInsets.only(right: 16.w),
                                child: (measurement as Pulse).pulseType == 0
                                    ? AppIcons.divan()
                                    : AppIcons.run(),
                              )
                            ]
                          ],
                        ),
                      ),
                      Text(
                        '${measurement.getFormattedDate()}, ручной ввод',
                        style: AppTypography.font12.copyWith(
                          color: AppColors.c9B9B9B,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
