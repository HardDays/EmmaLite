import 'dart:math';

import 'package:emma_mobile/bloc/app_settings/app_settings_bloc.dart';
import 'package:emma_mobile/bloc/app_settings/app_settings_state.dart';
import 'package:emma_mobile/bloc/profile_screen/profile_screen_bloc.dart';
import 'package:emma_mobile/bloc/profile_screen/profile_screen_state.dart';
import 'package:emma_mobile/ui/components/app_bar/small_app_bar.dart';
import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/measurement/default_container.dart';
import 'package:emma_mobile/ui/components/measurement/int_text_field.dart';
import 'package:emma_mobile/ui/components/profile/fields.dart';
import 'package:emma_mobile/ui/components/profile/image.dart';
import 'package:emma_mobile/ui/components/profile/profile_help_widget.dart';
import 'package:emma_mobile/ui/screens/profile/confirm_create.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class NewProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        body: Column(
          children: [
            SmallAppBar(
              leading: Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: AppIcons.chevronLeft(),
              ),
              title: 'Новый профиль',
            ),
            _ProfileInfoTip(),
            Expanded(
              child: BlocProvider(
                create: (_) => ProfileScreenBloc(checkStatus: true),
                lazy: false,
                child: _CreateProfile(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ProfileInfoTip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsBloc, AppSettingsState>(
      builder: (_, __) {
        final bloc = context.bloc<AppSettingsBloc>();
        if (bloc.appSettings.showProfileCreateHelp) {
          return const SizedBox();
        }
        return ProfileHelpWidget(
          text: 'Вы можете добавить к вашему аккаунту в EMMA Lite членов вашей семьи и следить за их здоровьем в одном приложении.',
          closeTap: bloc.setShowProfileCreateHelp,
        );
      },
    );
  }
}

class _CreateProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<ProfileScreenBloc>();
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      physics: const BouncingScrollPhysics(),
      child: BlocBuilder<ProfileScreenBloc, ProfileScreenState>(
        builder: (_, __) {
          return Provider.value(
            value: bloc.user,
            child: Column(
              children: [
                ProfilePickImage(),
                ProfileFields(),
                DefaultContainer(
                  child: InputTextField(
                    haveFormatter: false,
                    label: 'Статус',
                    type: TextInputType.text,
                    onChange: bloc.setStatus,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.h),
                  child: EmmaFilledButton(
                    title: 'Сохранить',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) {
                            return ConfirmCreate(user: bloc.user);
                          },
                        ),
                      );
                    },
                    isActive: bloc.canSave,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
