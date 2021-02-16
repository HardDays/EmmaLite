import 'package:emma_mobile/bloc/app_settings/app_settings_bloc.dart';
import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/ui/components/measurement/default_container.dart';
import 'package:emma_mobile/ui/components/measurement/int_text_field.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String oldPassword;

  const ChangePasswordScreen({Key key, this.oldPassword}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String _oldPassword;
  String _newPassword;
  String _repeatNewPassword;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.cF5F7FA,
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            EmmaAppBar(
              title: 'changePassword'.tr,
              leading: BackLeading(
                text: 'differenceBackTextLabel'.tr.capitalizeFirst,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: SizedBox(
                      width: 180.w,
                      child: Text(
                        'changePasswordTitle'.tr,
                        style: AppTypography.font16.copyWith(
                          color: AppColors.c3B4047,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  if (context.bloc<AppSettingsBloc>().appSettings.password !=
                      null)
                    Padding(
                      padding: EdgeInsets.only(top: 16.h),
                      child: DefaultContainer(
                        child: InputTextField(
                          label: 'oldPassword'.tr,
                          formatter: LengthLimitingTextInputFormatter(4),
                          onChange: (s) {
                            _oldPassword = s;
                          },
                        ),
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: DefaultContainer(
                      child: InputTextField(
                        label: 'newPassword'.tr,
                        formatter: LengthLimitingTextInputFormatter(4),
                        onChange: (s) {
                          _newPassword = s;
                        },
                      ),
                    ),
                  ),
                  DefaultContainer(
                    child: InputTextField(
                      label: 'repeatPassword'.tr,
                      formatter: LengthLimitingTextInputFormatter(4),
                      onChange: (s) {
                        _repeatNewPassword = s;
                      },
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 24.h,
                      horizontal: 16.w,
                    ),
                    child: EmmaFilledButton(
                      title: 'doneAppleHealthButtonTitle'.tr,
                      onTap: () {
                        if (_oldPassword != widget.oldPassword &&
                            widget.oldPassword != null) {
                          Toast.show('unCorrectPreviousPass'.tr);
                          return;
                        }
                        if (_repeatNewPassword != _newPassword) {
                          Toast.show('passwordsDoNotMatchTitle'.tr);
                        } else {
                          context
                              .bloc<AppSettingsBloc>()
                              .setPasswordText(_newPassword);
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
