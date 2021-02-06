import 'dart:io';

import 'package:emma_mobile/bloc/profile_screen/profile_screen_bloc.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePickImage extends StatelessWidget {
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
              decoration: profileImageDecoration(color: AppColors.cFFFFFF),
              width: 140.w,
              height: 140.w,
              child: Center(child: AppIcons.profile(size: 64.w)),
            )
          else
            ProfileImage(size: 140.w, url: bloc.user.photo),
        ],
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  final double size;
  final String url;

  const ProfileImage({Key key, this.size, this.url}) : super(key: key);

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
            File(url),
            fit: BoxFit.cover,
            width: size ?? 140.w,
            height: size ?? 140.w,
          ),
        ),
        Container(
          width: size ?? 140.w,
          height: size ?? 140.w,
          decoration: profileImageDecoration(),
          clipBehavior: Clip.antiAlias,
        ),
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