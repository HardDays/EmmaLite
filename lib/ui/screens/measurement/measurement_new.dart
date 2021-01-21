import 'package:emma_mobile/bloc/measurement/measurement_cubit.dart';
import 'package:emma_mobile/bloc/new_measurement_bloc/new_measurement_bloc.dart';
import 'package:emma_mobile/bloc/new_measurement_bloc/new_measurement_state.dart';
import 'package:emma_mobile/models/measurements/arterial_pressure.dart';
import 'package:emma_mobile/models/measurements/blood_sugar.dart';
import 'package:emma_mobile/models/measurements/height_model.dart';
import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/models/measurements/pulse.dart';
import 'package:emma_mobile/models/measurements/temperature.dart';
import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/components/bottom_sheet.dart';
import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/cupertino.dart'
    hide CupertinoDatePicker, CupertinoDatePickerMode, CupertinoPicker;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MeasurementNewScreen extends StatelessWidget {
  final Measurement item;
  final Function onSave;

  const MeasurementNewScreen({
    Key key,
    this.item,
    this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewMeasurementBloc(type: item),
      lazy: false,
      child: Builder(
        builder: (context) {
          final bloc = context.bloc<NewMeasurementBloc>();
          return Scaffold(
            backgroundColor: AppColors.cF5F7FA,
            // resizeToAvoidBottomInset: false,
            body: BlocBuilder<NewMeasurementBloc, NewMeasurementState>(
              builder: (_, state) {
                return Column(
                  children: [
                    EmmaAppBar(
                      title: 'Добавление ${item.inNewScreen}',
                      leading: SafeArea(
                        bottom: false,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 10.h,
                              bottom: 8.h,
                              left: 16.w,
                              right: 16.w,
                            ),
                            child: Text(
                              'Отменить',
                              style: AppTypography.font12.copyWith(
                                color: AppColors.c00ACE3,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: _DateTimeTextField(
                        value: bloc.dateTime,
                        onChange: bloc.setDateTime,
                        title: 'Дата и время измерения',
                        hintText: 'Дата и время измерения',
                      ),
                    ),
                    if (item is ArterialPressure) ...[
                      _DefaultContainer(
                        child: Column(
                          children: [
                            _IntTextField(
                              label: 'Систолическое давление ,${item.units}',
                              onChange: bloc.setArtPressureMin,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16.w),
                              child: ColoredBox(
                                color: AppColors.cE6E9EB,
                                child: SizedBox(
                                  height: 1.h,
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                            ),
                            _IntTextField(
                              label: 'Систолическое давление ,${item.units}',
                              onChange: bloc.setArtPressureMax,
                            ),
                          ],
                        ),
                      ),
                    ] else if (item is HeightModel) ...[
                      _DefaultContainer(
                        child: _IntTextField(
                          label: item.units,
                          onChange: bloc.setHeight,
                          isInt: false,
                        ),
                      )
                    ] else if (item is BloodSugar) ...[
                      _DoubleTextField(
                        title: item.title,
                        units: item.units,
                        isSugar: true,
                        onChange: bloc.setSugar,
                        value: bloc.sugar,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: _DateTimeTextField(
                          value: bloc.eatTime,
                          onChange: bloc.setEatTime,
                          title: 'Время приема пищи',
                          hintText: 'Время приема пищи (необязательно)',
                        ),
                      )
                    ] else if (item is Temperature) ...[
                      _DoubleTextField(
                        title: item.title,
                        units: item.units,
                        isSugar: false,
                        onChange: bloc.setTemperature,
                        value: bloc.temperature,
                      ),
                    ] else if (item is Pulse) ...[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            EmmaFilledButton(
                              child: AppIcons.divan(
                                color: _getColor(active: bloc.pulseType == 0),
                              ),
                              isActive: bloc.pulseType == 0,
                              width: 135.w,
                              height: 62.h,
                              inactiveColor: AppColors.cFFFFFF,
                              reverseTap: true,
                              borderRadius: 4,
                              onTap: () => bloc.setPulseType(type: 0),
                            ),
                            EmmaFilledButton(
                              child: AppIcons.run(
                                color: _getColor(active: bloc.pulseType == 1),
                              ),
                              width: 135.w,
                              height: 62.h,
                              isActive: bloc.pulseType == 1,
                              inactiveColor: AppColors.cFFFFFF,
                              reverseTap: true,
                              borderRadius: 4,
                              onTap: () => bloc.setPulseType(type: 1),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: _DefaultContainer(
                          child: _IntTextField(
                            label: '${item.title}, ${item.units}',
                            onChange: bloc.setPulse,
                          ),
                        ),
                      )
                    ],
                    const Spacer(),
                    EmmaFilledButton(
                      title: 'Сохранить',
                      width: 288.w,
                      activeColor: AppColors.c00ACE3,
                      isActive: bloc.enable,
                      onTap: () {
                        bloc.save();
                        context.bloc<MeasurementCubit>().reload();
                        onSave?.call();
                        Navigator.of(context).pop();
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 25.h),
                    )
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Color _getColor({bool active}) {
    return active ? AppColors.cFFFFFF : null;
  }
}

class _DefaultContainer extends StatelessWidget {
  final Widget child;
  final Function onTap;

  const _DefaultContainer({Key key, this.child, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(
          minWidth: 288.w,
          maxWidth: 288.w,
          minHeight: 62.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.cFFFFFF,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          boxShadow: [
            BoxShadow(
              color: AppColors.c000000.withOpacity(0.08),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

class _DateTimeTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final DateTime value;
  final Function(DateTime time) onChange;

  const _DateTimeTextField({
    Key key,
    this.title,
    this.value,
    this.hintText,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _DefaultContainer(
      onTap: () async {
        final res = await showDateTimeModalBottom(
          context: context,
          pickerTitle: title,
        );
        if (res != null) {
          onChange?.call(res);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          children: [
            if (value != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.font12.copyWith(
                      color: AppColors.c9B9B9B,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Text(
                      DateFormat('dd MMMM yyyy, HH:mm').format(value),
                      style: AppTypography.font16.copyWith(
                        color: AppColors.c4A4A4A,
                      ),
                    ),
                  )
                ],
              )
            else
              Text(
                hintText,
                style: AppTypography.font14.copyWith(
                  color: AppColors.cA7AFB8,
                ),
              ),
            const Spacer(),
            AppIcons.arrowRight(),
          ],
        ),
      ),
    );
  }
}

class _IntTextField extends StatefulWidget {
  final String label;
  final Function(String s) onChange;
  final bool isInt;

  const _IntTextField({
    Key key,
    this.label,
    this.onChange,
    this.isInt = true,
  }) : super(key: key);

  @override
  __IntTextFieldState createState() => __IntTextFieldState();
}

class __IntTextFieldState extends State<_IntTextField> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController()..addListener(_listener);
    super.initState();
  }

  void _listener() {
    widget.onChange(_controller.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w),
      child: Container(
        constraints: BoxConstraints(
          minHeight: 63.h,
          maxWidth: 288.w,
        ),
        child: TextField(
          keyboardType: TextInputType.number,
          controller: _controller,
          inputFormatters: [
            widget.isInt
                ? FilteringTextInputFormatter.digitsOnly
                : FilteringTextInputFormatter.allow(
                    RegExp(r'\d+(\.{0,1}\d{0,})'),
                  )
          ],
          style: AppTypography.font16.copyWith(color: AppColors.c4A4A4A),
          // onChanged: widget.onChange,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelStyle: AppTypography.font14.copyWith(color: AppColors.c9B9B9B),
            labelText: widget.label,
          ),
        ),
      ),
    );
  }
}

class _DoubleTextField extends StatelessWidget {
  final String title;
  final String units;
  final double value;
  final bool isSugar;
  final Function(double v) onChange;

  const _DoubleTextField({
    Key key,
    this.title,
    this.units,
    this.value,
    this.isSugar,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _DefaultContainer(
      onTap: () async {
        final res = await showDoublePicker(
          context: context,
          title: '$title, $units',
          firstMaxValue: isSugar ? 20 : 40,
          firstIndex: isSugar ? 2 : 4,
          firstStartValue: isSugar ? 2 : 32,
          secondMaxValue: 9,
          secondIndex: 0,
          secondStartValue: isSugar ? 0 : 6,
        );
        if (res is double) {
          onChange.call(res);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$title, $units',
                  style: AppTypography.font12.copyWith(
                    color: AppColors.c9B9B9B,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    '${value.toString()}   $units',
                    style: AppTypography.font16.copyWith(
                      color: AppColors.c4A4A4A,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            AppIcons.arrowRight(),
          ],
        ),
      ),
    );
  }
}
