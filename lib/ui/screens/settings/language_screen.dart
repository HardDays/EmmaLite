import 'package:emma_mobile/bloc/app_settings/app_settings_bloc.dart';
import 'package:emma_mobile/bloc/app_settings/app_settings_state.dart';
import 'package:emma_mobile/bloc/assign/assign_bloc.dart';
import 'package:emma_mobile/models/language.dart';
import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/measurement/default_container.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class LanguageScreen extends StatelessWidget {
  final Function onTap;

  const LanguageScreen({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cF5F7FA,
      body: Column(
        children: [
          EmmaAppBar(
            title: 'titleSettingLanguage'.tr,
            leading: BackLeading(text: 'mainSettingsTitle'.tr, onTap: onTap),
          ),
          BlocBuilder<AppSettingsBloc, AppSettingsState>(builder: (_, __) {
            return Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 16.w),
                physics: const BouncingScrollPhysics(),
                itemCount: languages.length,
                itemBuilder: (_, i) {
                  final bool isActive =
                      Get.locale.languageCode == languages[i].locale;
                  return DefaultContainer(
                    color: isActive ? AppColors.c00ACE3 : AppColors.cFFFFFF,
                    onTap: () {
                      context
                          .bloc<AppSettingsBloc>()
                          .setLocale(languages[i].locale);
                      context.bloc<AssignBloc>().reloadNotifications();
                    },
                    minHeight: 68.h,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: AppIcons.languageFlag(
                              path: languages[i].iconPath),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              languages[i].title,
                              style: AppTypography.font16.copyWith(
                                color: isActive
                                    ? AppColors.cFFFFFF
                                    : AppColors.c3B4047,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 2.h),
                              child: Text(
                                languages[i].localizedTitle,
                                style: AppTypography.font16.copyWith(
                                  color: isActive
                                      ? AppColors.cFFFFFF
                                      : AppColors.c9B9B9B,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (_, __) {
                  return Padding(padding: EdgeInsets.only(top: 8.h));
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
