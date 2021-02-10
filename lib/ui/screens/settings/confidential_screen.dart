import 'package:emma_mobile/bloc/app_settings/app_settings_bloc.dart';
import 'package:emma_mobile/bloc/app_settings/app_settings_state.dart';
import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/settings/settings_item.dart';
import 'package:emma_mobile/ui/screens/settings/change_password_screen.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfidentialScreen extends StatelessWidget {
  final Function() onTap;

  const ConfidentialScreen({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<AppSettingsBloc>();
    return Column(
      children: [
        EmmaAppBar(
          title: 'titleSettingsAddPassword'.tr,
          leading: BackLeading(
            text: 'mainSettingsTitle'.tr,
            onTap: onTap,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
          child: BlocBuilder<AppSettingsBloc, AppSettingsState>(
            builder: (_, __) {
              return Column(
                children: [
                  SettingsItem(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ChangePasswordScreen(
                            oldPassword: bloc.appSettings.password,
                          ),
                        ),
                      );
                    },
                    title: 'titleChangePassword'.tr,
                    icon: AppIcons.privacy(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25.h, bottom: 16.h),
                    child: Row(
                      children: [
                        Text(
                          'titleUsePassword'.tr,
                          style: AppTypography.font14.copyWith(
                            color: AppColors.c3B4047,
                          ),
                        ),
                        const Spacer(),
                        CupertinoSwitch(
                          activeColor: AppColors.c00ACE3,
                          value: bloc.appSettings.usePassword ?? false,
                          onChanged: bloc.setUsePassword,
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'titleUse'.tr,
                        style: AppTypography.font14.copyWith(
                          color: AppColors.c3B4047,
                        ),
                      ),
                      const Spacer(),
                      CupertinoSwitch(
                        value: bloc.appSettings.useFaceId ?? false,
                        activeColor: AppColors.c00ACE3,
                        onChanged: bloc.setUseFaceId,
                        // onChanged: bloc.setUseFaceId,
                      )
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
