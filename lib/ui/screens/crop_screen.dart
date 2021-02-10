import 'dart:io';

import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:simple_image_crop/simple_image_crop.dart';

class CropScreen extends StatelessWidget {
  final String path;

  const CropScreen({Key key, this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imgCropKey = GlobalKey<ImgCropState>();
    return Scaffold(
      backgroundColor: AppColors.c000000,
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          ImgCrop(
            key: imgCropKey,
            chipRadius: 150,
            chipShape: ChipShape.circle,
            image: FileImage(File(path)),
          ),
          _TopRow(),
          Positioned(
            bottom: 24.h,
            child: EmmaFilledButton(
              width: 296.w,
              onTap: () async {
                final crop = imgCropKey.currentState;
                final res = await crop.cropCompleted(
                  File(path),
                  preferredSize: 900,
                );
                Navigator.of(context).pop(res.path);
              },
              title: 'saveButtonText'.tr,
            ),
          ),
        ],
      ),
    );
  }
}

class _TopRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 30.h,
              ),
              Positioned(
                left: 0,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                    child: Text(
                      'titleCancelButton'.tr,
                      style: AppTypography.font12.copyWith(
                        color: AppColors.c00ACE3,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                'Выберите область',
                style: AppTypography.font16.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.cFFFFFF,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
