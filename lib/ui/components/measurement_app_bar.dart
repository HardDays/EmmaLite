import 'package:emma_mobile/bloc/measurement_detail_bloc/measurement_detail_bloc.dart';
import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/models/measurements/pulse.dart';
import 'package:emma_mobile/models/time_enum.dart';
import 'package:emma_mobile/models/time_range.dart';
import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/components/chip.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/screens/measurement/measurement_new.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeasurementDetailAppBar extends StatelessWidget {
  final String title;
  final DateTimeType initialType;
  final String arrowText;
  final Measurement item;
  final Function(DateTimeType type) onChange;

  const MeasurementDetailAppBar({
    Key key,
    this.title,
    this.initialType,
    this.arrowText,
    this.item,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.cFFFFFF,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TopRow(arrowText: arrowText, item: item),
          Padding(
            padding: EdgeInsets.only(left: 16.w, bottom: 11.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.font19.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.c3B4047,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 8.w),
            child: Row(
              children: [
                for (var i = 0; i < dateTimeTypes.length; i++)
                  if (i == 0) ...[
                    if (item is Pulse)
                      ChipItem(
                        title: dateTimeTypes[i].timeValue,
                        isActive: dateTimeTypes[i] == initialType,
                        onTap: () => onChange(dateTimeTypes[i]),
                      )
                  ] else
                    ChipItem(
                      title: dateTimeTypes[i].timeValue,
                      isActive: dateTimeTypes[i] == initialType,
                      onTap: () => onChange(dateTimeTypes[i]),
                    ),
              ],
            ),
          ),
          _DatesSelect(type: initialType),
          Container(
            height: 1.h,
            width: MediaQuery.of(context).size.width,
            color: AppColors.cE6E9EB,
          ),
        ],
      ),
    );
  }
}

class _TopRow extends StatelessWidget {
  final String arrowText;
  final Measurement item;

  const _TopRow({this.arrowText, this.item, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.only(top: 11.h),
        child: Row(
          children: [
            BackLeading(text: arrowText ?? 'Измерения'),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(
                left: 12.w,
                right: 8.w,
                top: 10.h,
                bottom: 10.h,
              ),
              child: AppIcons.calendarActive(),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      return MeasurementNewScreen(
                        item: item,
                        onSave: () {
                          context.bloc<MeasurementDetailBloc>().reload();
                        },
                      );
                    },
                  ),
                );
              },
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 8.w,
                  right: 16.w,
                  top: 10.h,
                  bottom: 10.h,
                ),
                child: AppIcons.plus(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _DatesSelect extends StatelessWidget {
  final DateTimeType type;

  const _DatesSelect({Key key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<MeasurementDetailBloc>();
    final list = bloc.ranges;
    final countOnPage = bloc.type.countOnPage;
    final countPages = bloc.ranges.length / countOnPage;
    return SizedBox(
      height: 34.h,
      child: PageView.builder(
        key: ValueKey(type.toString()),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        reverse: true,
        itemCount: countPages.ceil(),
        itemBuilder: (_, i) {
          final s = <Widget>[];
          for (var j = 0; j < bloc.type.countOnPage; j++) {
            final index = i == 0 ? j : j + (i * countOnPage);
            if (index >= list.length) {
              s.insert(0, const Expanded(child: SizedBox()));
            } else {
              s.add(Expanded(child: _TimeRangeView(timeRange: list[index])));
            }
          }
          return Row(
            children: s.reversed.toList(),
          );
        },
      ),
    );
  }
}

class _TimeRangeView extends StatelessWidget {
  final TimeRange timeRange;

  const _TimeRangeView({Key key, this.timeRange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<MeasurementDetailBloc>();
    final isActive = bloc.activeTimeRange == timeRange;
    return GestureDetector(
      onTap: () {
        bloc.setTimeRange(timeRange);
      },
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: Text(
          timeRange.toString(),
          style: AppTypography.font12.copyWith(
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
            color: isActive ? AppColors.c00ACE3 : AppColors.cBFBFBF,
          ),
        ),
      ),
    );
  }
}
