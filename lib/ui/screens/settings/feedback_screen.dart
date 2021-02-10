import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/ui/components/measurement/default_container.dart';
import 'package:emma_mobile/ui/components/measurement/int_text_field.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class FeedbackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          EmmaAppBar(title: 'titleFeedback'.tr),
          Expanded(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              behavior: HitTestBehavior.opaque,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: 15.h,
                  bottom: 24.h,
                  left: 16.w,
                  right: 16.w,
                ),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 25.h),
                      child: Text(
                        'Задайте свой вопрос',
                        style: AppTypography.font16.copyWith(
                          color: AppColors.c3B4047,
                        ),
                      ),
                    ),
                    DefaultContainer(
                      child: InputTextField(
                        haveFormatter: false,
                        type: TextInputType.text,
                        label: 'Суть проблемы',
                        maxLines: null,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.h, bottom: 167.h),
                      child: DefaultContainer(
                        minHeight: 100.h,
                        child: InputTextField(
                          haveFormatter: false,
                          type: TextInputType.text,
                          label: 'Опишите проблему подробнее',
                          maxLines: null,
                        ),
                      ),
                    ),
                    EmmaFilledButton(
                      title: 'sendButtonText'.tr,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
