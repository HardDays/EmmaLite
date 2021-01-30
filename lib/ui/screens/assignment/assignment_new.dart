import 'dart:io';

import 'package:emma_mobile/bloc/new_assing_bloc/new_assign_bloc.dart';
import 'package:emma_mobile/bloc/new_assing_bloc/new_assign_state.dart';
import 'package:emma_mobile/models/assignment/assign_frequency.dart';
import 'package:emma_mobile/models/assignment/assign_type.dart';
import 'package:emma_mobile/models/assignment/assign_unit.dart';
import 'package:emma_mobile/models/assignment/assignment.dart';
import 'package:emma_mobile/ui/components/app_bar/small_app_bar.dart';
import 'package:emma_mobile/ui/components/bottom_sheet.dart';
import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/measurement/date_time_text_field.dart';
import 'package:emma_mobile/ui/components/measurement/default_container.dart';
import 'package:emma_mobile/ui/components/measurement/default_picker_field.dart';
import 'package:emma_mobile/ui/components/measurement/int_text_field.dart';
import 'package:emma_mobile/ui/components/modal_widget.dart';
import 'package:emma_mobile/ui/screens/detail_photo_screen.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AssignmentNewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewAssignBloc(),
      lazy: false,
      child: Scaffold(
        backgroundColor: AppColors.cF5F7FA,
        body: Column(
          children: [
            const SmallAppBar(
              title: 'Новое назначение',
              leadingText: 'Отменить',
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: _NewAssign(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NewAssign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<NewAssignBloc>();
    return BlocBuilder<NewAssignBloc, NewAssignState>(
      builder: (_, state) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: DefaultPickerField(
                title: 'Тип назначения',
                index: bloc.assignment.typeId,
                values: assignTypes,
                onChange: bloc.setType,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: DefaultContainer(
                child: InputTextField(
                  formatter: LengthLimitingTextInputFormatter(27),
                  type: TextInputType.text,
                  label: 'Название назначения',
                ),
              ),
            ),
            DefaultContainer(
              child: Column(
                children: [
                  InputTextField(
                    isInt: true,
                    label: 'Дозировка',
                    onChange: bloc.setDosage,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: Container(
                      height: 1.h,
                      width: MediaQuery.of(context).size.width,
                      color: AppColors.cE6E9EB,
                    ),
                  ),
                  DefaultPickerField(
                    title: 'Единица измерения',
                    index: bloc.assignment.unitId,
                    values: assignUnits,
                    onChange: bloc.setUnit,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: DefaultContainer(
                child: Column(
                  children: [
                    DateTimeTextField(
                      title: 'Дата начала',
                      hintText: 'Дата начала',
                      dateFormat: DateFormat('dd MMMM yyyy'),
                      value: bloc.assignment.startTime,
                      onChange: bloc.setStartTime,
                      haveDecoration: false,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Container(
                        height: 1.h,
                        width: MediaQuery.of(context).size.width,
                        color: AppColors.cE6E9EB,
                      ),
                    ),
                    DateTimeTextField(
                      title: 'Дата окончания',
                      hintText: 'Дата окончания',
                      dateFormat: DateFormat('dd MMMM yyyy'),
                      value: bloc.assignment.endTime,
                      minimumDate: DateTime.now(),
                      onChange: bloc.setEndTime,
                      haveDecoration: false,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: DefaultPickerField(
                title: 'Частота',
                index: bloc.assignment.frequency,
                onChange: bloc.setFrequency,
                hintText: 'Частота',
                values: assignFrequency,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: DefaultContainer(
                minHeight: 94.h,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 13.w,
                    top: 8.h,
                    bottom: 4.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Периодичность:',
                        style: AppTypography.font12.copyWith(
                          color: AppColors.c9B9B9B,
                        ),
                      ),
                      _RadioButton(
                        title: 'Регулярно',
                        onTap: () => bloc.setIsRegular(regular: true),
                        value: bloc.assignment.isRegular,
                      ),
                      _RadioButton(
                        title: 'Единоразово',
                        onTap: () => bloc.setIsRegular(regular: false),
                        value: !bloc.assignment.isRegular,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (!bloc.assignment.isRegular) ...[
              ListView.builder(
                itemCount: bloc.assignment.singleTasks.length,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, i) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: DefaultPickerField(
                          title: 'День недели',
                          index: bloc.assignment.singleTasks[i].dayNumber,
                          hintText: 'День недели',
                          onChange: (value) => bloc.setWeekday(
                            dayNumber: value,
                            taskNumber: i,
                          ),
                          values: assignFrequencyWeekday,
                        ),
                      ),
                      _TimesGrid(
                        taskTimes: bloc.assignment.singleTasks[i].taskTimes,
                        onChange: (time, index) {
                          bloc.setSingleTime(
                            index: index,
                            taskTime: time,
                            taskIndex: i,
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
              _NewAndDeleteRow(),
            ] else ...[
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: DefaultPickerField(
                      title: 'Регулярность',
                      index: bloc.assignment.periodicTask.type.index,
                      hintText: 'Регулярность',
                      onChange: (value) => bloc.setRegularTypeCount(
                        AssignFrequencyInWeekEnum.values[value],
                      ),
                      values: assignFrequencyInWeek,
                    ),
                  ),
                  _TimesGrid(
                    taskTimes: bloc.assignment.periodicTask.taskTimes,
                    onChange: (time, index) {
                      bloc.setPeriodicTime(taskTime: time, index: index);
                    },
                  ),
                ],
              )
            ],
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: DefaultContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InputTextField(
                        label: 'Кто назначил',
                        isInt: false,
                        formatter: LengthLimitingTextInputFormatter(27),
                        type: TextInputType.text,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Container(
                        width: 44.h,
                        height: 44.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.cEBEEF3,
                        ),
                        child: Center(child: AppIcons.doctors()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _Photos(),
            Padding(
              padding: EdgeInsets.only(top: 20.h, bottom: 32.h),
              child: EmmaFilledButton(
                title: 'Сохранить',
              ),
            )
          ],
        );
      },
    );
  }
}

class _NewAndDeleteRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<NewAssignBloc>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: bloc.addSingleTask,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: EdgeInsets.only(top: 10.h, left: 15.w),
            child: Row(
              children: [
                AppIcons.plus(size: 14.w, color: AppColors.cA7AFB8),
                Padding(
                  padding: EdgeInsets.only(left: 17.w),
                  child: Text(
                    'Добавить еще',
                    style: AppTypography.font12.copyWith(
                      color: AppColors.c9B9B9B,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: bloc.removeSingleTask,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: EdgeInsets.only(top: 10.h, right: 16.w),
            child: Row(
              children: [
                AppIcons.trash(color: AppColors.cA7AFB8),
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Text(
                    'Удалить',
                    style: AppTypography.font12.copyWith(
                      color: AppColors.c9B9B9B,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TimesGrid extends StatelessWidget {
  final List<TaskTime> taskTimes;
  final Function(TaskTime taskTime, int index) onChange;

  const _TimesGrid({
    Key key,
    this.taskTimes,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<NewAssignBloc>();
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 2.25,
        crossAxisCount: 2,
        crossAxisSpacing: 20.w,
        mainAxisSpacing: 20.h,
      ),
      itemCount: taskTimes.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (_, i) {
        return _TimeItem(
          taskTime: taskTimes[i],
          onTap: () async {
            final res = await showCustomTimePicker(
              context: context,
              timeRange: PickerTimeRange.calculate(
                currentNumber: i,
                maxCount: bloc.assignment.frequency + 1,
              ),
              time: taskTimes[i],
            );
            if (res is TaskTime) {
              onChange.call(res, i);
            }
          },
        );
      },
    );
  }
}

class _TimeItem extends StatelessWidget {
  final TaskTime taskTime;
  final Function onTap;

  const _TimeItem({Key key, this.taskTime, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultContainer(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
          top: 8.h,
          left: 16.w,
          right: 16.w,
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Количество:',
                  style: AppTypography.font12.copyWith(
                    color: AppColors.c9B9B9B,
                  ),
                ),
                const Spacer(),
                Text(
                  '${taskTime.time.hour}:${taskTime.time.minutes.twoDigits}',
                  style: AppTypography.font16.copyWith(
                    color: AppColors.c4A4A4A,
                  ),
                ),
                const Spacer(),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 3.w),
              child: Text(
                taskTime.count.toString(),
                style: AppTypography.font16.copyWith(
                  color: AppColors.c4A4A4A,
                ),
              ),
            ),
            const Spacer(),
            AppIcons.arrowRight()
          ],
        ),
      ),
    );
  }
}

class _RadioButton extends StatelessWidget {
  final bool value;
  final String title;
  final Function onTap;

  const _RadioButton({
    Key key,
    this.value = true,
    this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: value ? null : onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTypography.font16.copyWith(color: AppColors.c4A4A4A),
            ),
            Container(
              width: 18.w,
              height: 18.w,
              decoration: BoxDecoration(
                  color: AppColors.cEBEEF3,
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1.w,
                    color: AppColors.cA7AFB8,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.05),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    )
                  ]),
              child: value
                  ? Center(
                      child: Container(
                        width: 10.w,
                        height: 10.w,
                        decoration: const BoxDecoration(
                          color: AppColors.c00ACE3,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}

class _Photos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<NewAssignBloc>();
    return Column(
      children: [
        if (bloc.assignment.photos.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 20.w,
                mainAxisSpacing: 20.h,
              ),
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: bloc.assignment.photos.length,
              itemBuilder: (_, i) {
                return _Photo(index: i);
              },
            ),
          ),
        Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: GestureDetector(
            onTap: bloc.pickImage,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.only(
                right: 16.w,
                top: 12.h,
                bottom: 12.h,
              ),
              child: Row(
                children: [
                  AppIcons.paperClip(),
                  Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: Text(
                      'Добавить изображение',
                      style: AppTypography.font16.copyWith(
                        color: AppColors.c00ACE3,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Photo extends StatelessWidget {
  final int index;

  const _Photo({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<NewAssignBloc>();
    return Center(
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        clipBehavior: Clip.antiAlias,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  return DetailPhotoScreen(
                    photos: bloc.assignment.photos,
                    initIndex: index,
                    onDelete: (i) => bloc.deletePhoto(index: i),
                  );
                },
              ),
            );
          },
          child: Stack(
            children: [
              SizedBox(
                width: 134.w,
                height: 134.w,
              ),
              Image.file(
                File(bloc.assignment.photos[index]),
                width: 134.w,
                height: 134.w,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: 137.w,
                  height: 40.h,
                  color: AppColors.cFFFFFF.withOpacity(0.7),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        showCupertinoWith2Button(
                          context,
                          leftText: 'Да',
                          rightText: 'Нет',
                          subtitle: 'Удалить изображение?',
                          leftTap: (context) {
                            bloc.deletePhoto(index: index);
                            Navigator.of(context).pop();
                          },
                          rightTap: (context) {
                            Navigator.of(context).pop();
                          }
                        );
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: EdgeInsets.only(right: 9.w, bottom: 1.h),
                        child: AppIcons.trash(
                          color: AppColors.c3B4047,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
