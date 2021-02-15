import 'dart:io';

import 'package:emma_mobile/bloc/profile/profile_cubit.dart';
import 'package:emma_mobile/bloc/profile_screen/profile_screen_bloc.dart';
import 'package:emma_mobile/models/user/user.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileTrailing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.bloc<ProfileCubit>().currentUser;
    if (user.isEmpty) {
      return const SizedBox();
    }
    return Padding(
      padding: EdgeInsets.only(right: 12.w, top: 5.h),
      child: ProfileImage(
        user: user,
        size: 30.w,
        showactual: false,
        textSize: Constants.textSize10,
      ),
    );
  }
}

class ProfilePickImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<ProfileScreenBloc>();
    return Padding(
      padding: EdgeInsets.only(top: 24.h),
      child: GestureDetector(
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
                decoration: profileImageDecoration(color: AppColors.cFFFFFF),
                width: 140.w,
                height: 140.w,
                child: Center(child: AppIcons.profile(size: 64.w)),
              )
            else
              ProfileImage(size: 140.w, user: bloc.user),
            if (bloc.user.photo.isEmpty)
              Padding(
                padding: EdgeInsets.only(top: 16.h),
                child: Text(
                  'youCanAddPhoto'.tr,
                  style: AppTypography.font14.copyWith(
                    color: AppColors.c9B9B9B,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  final double size;
  final User user;
  final bool showactual;
  final double textSize;

  const ProfileImage({
    Key key,
    this.size,
    this.user,
    this.showactual = true,
    this.textSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          clipBehavior: Clip.antiAlias,
          child: user.photo.isEmpty
              ? Container(
                  width: size ?? 140.w,
                  height: size ?? 140.w,
                  color: context.bloc<ProfileCubit>().colorIfEmpty(user),
                  child: Center(
                    child: Text(
                      user.initials,
                      style: AppTypography.font32.copyWith(
                        fontSize: textSize,
                        color: AppColors.cFFFFFF,
                      ),
                    ),
                  ),
                )
              : Image.file(
                  File(user.photo),
                  fit: BoxFit.fill,
                  width: size ?? 140.w,
                  height: size ?? 140.w,
                ),
        ),
        if (showactual)
          Container(
            width: size ?? 140.w,
            height: size ?? 140.w,
            decoration: profileImageDecoration(),
            clipBehavior: Clip.antiAlias,
          ),
        if (user.id == context.bloc<ProfileCubit>().currentUser.id &&
            showactual)
          Positioned(
            top: 4.w,
            right: 0,
            child: Container(
              width: 28.w,
              height: 28.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.c00ACE3,
              ),
              child: Center(
                child: AppIcons.check(size: 14.w),
              ),
            ),
          )
      ],
    );
  }
}

class SmallProfileImage extends StatelessWidget {
  final User user;

  const SmallProfileImage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.bloc<ProfileCubit>().colorIfEmpty(user),
          ),
          clipBehavior: Clip.antiAlias,
          width: 56.h,
          height: 56.h,
          child: user.photo.isEmpty
              ? Center(
                  child: Text(
                    user.initials,
                    style: AppTypography.font24.copyWith(
                      color: AppColors.cFFFFFF,
                    ),
                  ),
                )
              : Image.file(
                  File(user.photo),
                  fit: BoxFit.fill,
                  width: 56.h,
                  height: 56.h,
                ),
        ),
        if (user.id == context.bloc<ProfileCubit>().currentUser.id)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 20.h,
              height: 20.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.c00ACE3,
              ),
              child: Center(
                child: AppIcons.check(size: 10.h),
              ),
            ),
          )
      ],
    );
  }
}

BoxDecoration profileImageDecoration({Color color}) {
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
