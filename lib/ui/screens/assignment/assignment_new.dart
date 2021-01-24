import 'dart:io';

import 'package:emma_mobile/bloc/new_assing_bloc/new_assign_bloc.dart';
import 'package:emma_mobile/bloc/new_assing_bloc/new_assign_state.dart';
import 'package:emma_mobile/models/assignment/assign_type.dart';
import 'package:emma_mobile/models/assignment/assign_unit.dart';
import 'package:emma_mobile/ui/components/app_bar/small_app_bar.dart';
import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/measurement/date_time_text_field.dart';
import 'package:emma_mobile/ui/components/measurement/default_container.dart';
import 'package:emma_mobile/ui/components/measurement/default_picker_field.dart';
import 'package:emma_mobile/ui/components/measurement/int_text_field.dart';
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
      child: Scaffold(
        backgroundColor: AppColors.cF5F7FA,
        body: Column(
          children: [
            SmallAppBar(
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
    return BlocBuilder<NewAssignBloc, NewAssignState>(builder: (_, state) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: DefaultPickerField(
              title: 'Тип назначения:',
              index: 0,
              values: assignTypes,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: DefaultContainer(
              child: InputTextField(
                formatter: LengthLimitingTextInputFormatter(27),
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
                  title: 'Единица измерения:',
                  index: 0,
                  values: assignUnits,
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
                    value: DateTime.now(),
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
                    value: DateTime.now(),
                    haveDecoration: false,
                  ),
                ],
              ),
            ),
          ),
          if (bloc.photos.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: SizedBox(
                height: 134.w,
                width: MediaQuery.of(context).size.width,
                child: ListView.separated(
                  itemCount: bloc.photos.length,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, i) {
                    return _Photo(index: i);
                  },
                  separatorBuilder: (_, __) {
                    return Padding(padding: EdgeInsets.only(left: 20.w));
                  },
                ),
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
          Padding(
            padding: EdgeInsets.only(top: 20.h, bottom: 32.h),
            child: EmmaFilledButton(
              title: 'Сохранить',
            ),
          )
        ],
      );
    });
  }
}

class _Photo extends StatelessWidget {
  final int index;

  const _Photo({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<NewAssignBloc>();
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) {
                return DetailPhotoScreen(
                  photos: bloc.photos,
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
              File(bloc.photos[index]),
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
                      bloc.deletePhoto(index: index);
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
    );
  }
}
