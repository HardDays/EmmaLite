import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/ui/components/measurement/default_container.dart';
import 'package:emma_mobile/ui/components/measurement/int_text_field.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            const EmmaAppBar(
              title: 'Изменение пароля',
              leading: BackLeading(text: 'Назад'),
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    child: SizedBox(
                      width: 180.w,
                      child: Text(
                        'Введите текущий пароль и придумайте новый',
                        style: AppTypography.font16.copyWith(
                          color: AppColors.c3B4047,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  DefaultContainer(
                    child: InputTextField(
                      label: 'Старый пароль',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: DefaultContainer(
                      child: InputTextField(
                        label: 'Новый пароль',
                      ),
                    ),
                  ),
                  DefaultContainer(
                    child: InputTextField(
                      label: 'Повторите пароль',
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 24.h,
                      horizontal: 16.w,
                    ),
                    child: EmmaFilledButton(
                      title: 'Готово',
                      onTap: () {},
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
