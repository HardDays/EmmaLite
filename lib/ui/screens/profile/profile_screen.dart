import 'dart:io';

import 'package:emma_mobile/bloc/profile/profile_cubit.dart';
import 'package:emma_mobile/bloc/profile/profile_state.dart';
import 'package:emma_mobile/bloc/profile_screen/profile_screen_bloc.dart';
import 'package:emma_mobile/bloc/profile_screen/profile_screen_state.dart';
import 'package:emma_mobile/models/user/user.dart';
import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/measurement/date_time_text_field.dart';
import 'package:emma_mobile/ui/components/measurement/default_container.dart';
import 'package:emma_mobile/ui/components/measurement/int_text_field.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<ProfileCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (_, __) {
        if (bloc.currentUser.isEmpty) {
          return Scaffold(
            body: BlocProvider(
              create: (_) => ProfileScreenBloc(),
              child: _EmptyProfile(),
            ),
          );
        }
        return Provider.value(
          value: bloc.currentUser,
          child: _CurrentProfile(),
        );
      },
    );
  }
}

class _CurrentProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const EmmaAppBar(title: 'Профиль'),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 24.h),
                  child: _ProfileImage(size: 120.w),
                ),
                IgnorePointer(
                  ignoring: true,
                  child: _Fields(),
                ),
                Padding(padding: EdgeInsets.only(top: 56.h)),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _EmptyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<ProfileScreenBloc>();
    return BlocBuilder<ProfileScreenBloc, ProfileScreenState>(
      builder: (_, __) {
        return Column(
          children: [
            const EmmaAppBar(title: 'Профиль'),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                physics: const BouncingScrollPhysics(),
                child: Provider.value(
                  value: bloc.user,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 24.h),
                        child: _Image(),
                      ),
                      if (bloc.user.photo.isEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: 16.h),
                          child: Text(
                            'Вы можете добавить свое фото. Оно будет отображаться только в отчете.',
                            style: AppTypography.font14.copyWith(
                              color: AppColors.c9B9B9B,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      _Fields(),
                      EmmaFilledButton(
                        title: 'Сохранить',
                        onTap: () {
                          context.bloc<ProfileCubit>().addUser(bloc.user);
                        },
                        isActive: bloc.user.canSave,
                      ),
                      KeyboardVisibilityBuilder(
                        builder: (_, isKeyboardVisible) {
                          return Padding(
                            padding: EdgeInsets.only(
                              top: isKeyboardVisible ? 24.h : 80.h,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Fields extends StatelessWidget {
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
                  label: 'Имя',
                ),
                _Divider(),
                InputTextField(
                  type: TextInputType.text,
                  initialValue: user.lastName,
                  onChange: (s) {
                    context.bloc<ProfileScreenBloc>().setLastName(s);
                  },
                  haveFormatter: false,
                  label: 'Фамилия',
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
                  title: 'Дата рождения',
                  hintText: 'Дата рождения',
                ),
                _Divider(),
                Row(
                  children: [
                    Expanded(
                      child: InputTextField(
                        label: 'Вес',
                        initialValue: user.weight?.toString(),
                        isInt: false,
                        onChange: (s) {
                          context.bloc<ProfileScreenBloc>().setWeight(s);
                        },
                      ),
                    ),
                    _ArrowIcon(),
                  ],
                ),
                _Divider(),
                Row(
                  children: [
                    Expanded(
                      child: InputTextField(
                        label: 'Рост',
                        initialValue: user.height?.toString(),
                        isInt: false,
                        onChange: (s) {
                          context.bloc<ProfileScreenBloc>().setHeight(s);
                        },
                      ),
                    ),
                    _ArrowIcon(),
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
          padding: EdgeInsets.only(top: 12.h, bottom: 24.h),
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

class _Image extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<ProfileScreenBloc>();
    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (context2) {
            return CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.of(context2).pop();
                    bloc.pickPhoto(
                      context: context,
                      imageSource: ImageSource.camera,
                    );
                  },
                  child: Text(
                    'Сделать фото',
                    style: AppTypography.font18.copyWith(
                      color: AppColors.c00ACE3,
                    ),
                  ),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.of(context2).pop();
                    bloc.pickPhoto(
                      context: context,
                      imageSource: ImageSource.gallery,
                    );
                  },
                  child: Text(
                    'Выбрать из галереи',
                    style: AppTypography.font18.copyWith(
                      color: AppColors.c00ACE3,
                    ),
                  ),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                    bloc.deletePhoto();
                  },
                  child: Text(
                    'Удалить фотографию',
                    style: AppTypography.font18.copyWith(
                      color: AppColors.cFF3B30,
                    ),
                  ),
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Отмена',
                  style: AppTypography.font18.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.c00ACE3,
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Column(
        children: [
          if (bloc.user.photo.isEmpty)
            Container(
              decoration: _imageDecoration(color: AppColors.cFFFFFF),
              width: 140.w,
              height: 140.w,
              child: Center(child: AppIcons.profile(size: 64.w)),
            )
          else
            _ProfileImage(size: 140.w),
        ],
      ),
    );
  }
}

class _ProfileImage extends StatelessWidget {
  final double size;

  const _ProfileImage({Key key, this.size}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.file(
            File(Provider.of<User>(context).photo),
            fit: BoxFit.cover,
            width: size ?? 140.w,
            height: size ?? 140.w,
          ),
        ),
        Container(
          width: size ?? 140.w,
          height: size ?? 140.w,
          decoration: _imageDecoration(),
          clipBehavior: Clip.antiAlias,
        ),
      ],
    );
  }
}


class _Divider extends StatelessWidget {
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

class _ArrowIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: AppIcons.arrowRight(),
    );
  }
}

BoxDecoration _imageDecoration({Color color}) {
  return BoxDecoration(
    shape: BoxShape.circle,
    color: color,
    border: Border.all(
      color: AppColors.cFFFFFF,
      width: 4.w,
    ),
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.08),
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
  );
}
