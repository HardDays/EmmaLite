import 'package:emma_mobile/bloc/profile_screen/profile_screen_bloc.dart';
import 'package:emma_mobile/models/user/user.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/measurement/date_time_text_field.dart';
import 'package:emma_mobile/ui/components/measurement/default_container.dart';
import 'package:emma_mobile/ui/components/measurement/int_text_field.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfileFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 24.h),
          child: DefaultContainer(
            child: Column(
              children: [
                InputTextField(
                  type: TextInputType.text,
                  initialValue: user.firstName,
                  onChange: (s) {
                    context.bloc<ProfileScreenBloc>().setFirstName(s);
                  },
                  haveFormatter: false,
                  label: 'titleFirstName'.tr,
                ),
                ProfileDivider(),
                InputTextField(
                  type: TextInputType.text,
                  initialValue: user.lastName,
                  onChange: (s) {
                    context.bloc<ProfileScreenBloc>().setLastName(s);
                  },
                  haveFormatter: false,
                  label: 'titleLastName'.tr,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DefaultContainer(
                minHeight: 58.h,
                width: 138.w,
                color: user.gender == Gender.male ? AppColors.c00ACE3 : null,
                onTap: () =>
                    context.bloc<ProfileScreenBloc>().setGender(Gender.male),
                child: Center(
                  child: Text(
                    'Мужской',
                    style: AppTypography.font16.copyWith(
                      color: user.gender == Gender.male
                          ? AppColors.cFFFFFF
                          : AppColors.c9B9B9B,
                    ),
                  ),
                ),
              ),
              DefaultContainer(
                minHeight: 58.h,
                width: 138.w,
                color: user.gender == Gender.female ? AppColors.c00ACE3 : null,
                onTap: () =>
                    context.bloc<ProfileScreenBloc>().setGender(Gender.female),
                child: Center(
                  child: Text(
                    'Женский',
                    style: AppTypography.font16.copyWith(
                      color: user.gender == Gender.female
                          ? AppColors.cFFFFFF
                          : AppColors.c9B9B9B,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
          child: DefaultContainer(
            child: Column(
              children: [
                DateTimeTextField(
                  haveDecoration: false,
                  value: user.date,
                  onChange: (d) {
                    context.bloc<ProfileScreenBloc>().setBirthday(d);
                  },
                  mode: CupertinoDatePickerMode.date,
                  dateFormat: DateFormat('dd.MM.yyyy'),
                  title: 'birthdayTitle'.tr,
                  hintText: 'birthdayTitle'.tr,
                ),
                ProfileDivider(),
                Row(
                  children: [
                    Expanded(
                      child: InputTextField(
                        label: 'weightTitle'.tr,
                        initialValue: user.weight?.toString(),
                        isInt: false,
                        onChange: (s) {
                          context.bloc<ProfileScreenBloc>().setWeight(s);
                        },
                      ),
                    ),
                    ArrowIcon(),
                  ],
                ),
                ProfileDivider(),
                Row(
                  children: [
                    Expanded(
                      child: InputTextField(
                        label: 'growthTitle'.tr,
                        initialValue: user.height?.toString(),
                        isInt: false,
                        onChange: (s) {
                          context.bloc<ProfileScreenBloc>().setHeight(s);
                        },
                      ),
                    ),
                    ArrowIcon(),
                  ],
                ),
              ],
            ),
          ),
        ),
        DefaultContainer(
          child: InputTextField(
            label: 'Телефон',
            initialValue: user.phone,
            formatter: PhoneTextInputFormatter(),
            onChange: (s) {
              context.bloc<ProfileScreenBloc>().setPhone(s);
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: DefaultContainer(
            child: InputTextField(
              label: 'Email',
              initialValue: user.email,
              haveFormatter: false,
              formatRegExp: RegExp(Constants.emailRegex),
              type: TextInputType.emailAddress,
              onChange: (s) {
                context.bloc<ProfileScreenBloc>().setEmail(s);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class ProfileDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 272.w,
        height: 1.h,
        color: AppColors.cE6E9EB,
      ),
    );
  }
}

class ArrowIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: AppIcons.arrowRight(),
    );
  }
}
