import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class AboutTextScreen extends StatelessWidget {
  final String title;
  final String text;

  const AboutTextScreen({Key key, this.title, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      body: Column(
        children: [
          EmmaAppBar(
            title: title,
            leading: BackLeading(
              text: 'differenceBackTextLabel'.tr.capitalizeFirst,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Text(
                text,
                style: AppTypography.font14.copyWith(
                  color: AppColors.c9B9B9B,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
