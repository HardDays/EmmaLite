import 'package:emma_mobile/bloc/profile/profile_cubit.dart';
import 'package:emma_mobile/models/user/user.dart';
import 'package:emma_mobile/ui/components/buttons/emma_border_button.dart';
import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/ui/images.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmCreate extends StatelessWidget {
  final User user;

  const ConfirmCreate({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cF5F7FA,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 49.h, bottom: 20.h),
                child: AppImages.agreement(),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15.h),
                child: Text(
                  'consentToTheProcessingOfPersonalDataMainLabelTitle'.tr,
                  style: AppTypography.font16.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.c3B4047,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Text(
                  'Мы не используем ваши персональные данные и не передаем их третьим лицам.  И еще много много юридичского текста. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce consequat turpis vitae ullamcorper rutrum. Duis fermentum nisl at ante auctor, nec convallis risus pretium. Fusce diam lacus, aliquam nec orci auctor, scelerisque volutpat risus. Sed gravida sit amet sem quis faucibus. Nam dignissim, nisi at lacinia commodo, lorem diam pellentesque felis, nec commodo sem purus at erat. Mauris at neque mattis enim tristique ornare. Mauris leo dolor, bibendum eu placerat vehicula, fringilla sit amet augue. Integer sollicitudin pulvinar ornare. Morbi at enim vel tortor suscipit maximus. In congue cursus consequat. Vivamus scelerisque, metus quis posuere ornare, velit ipsum viverra felis, vitae commodo sem sem et odio. Curabitur dignissim nec neque vel venenatis. Pellentesque ut nulla justo. Fusce egestas mauris non metus dignissim, et condimentum quam convallis. Nulla convallis sit amet arcu a bibendum. Nam tempor interdum turpis, non vestibulum dolor lobortis eu. Donec vitae lectus bibendum, convallis dui vitae, pellentesque nulla. Integer quis risus id diam fermentum malesuada quis quis tortor. Sed eget ligula metus. Proin efficitur dignissim libero, sit amet pulvinar nisi vehicula et. Suspendisse facilisis non enim a venenatis. Suspendisse et nibh purus.',
                  style: AppTypography.font14.copyWith(
                    color: AppColors.c9B9B9B,
                  ),
                ),
              ),
              EmmaFilledButton(
                title: 'confirmMyConsentButtonTitle'.tr,
                height: 50.h,
                width: 288.w,
                onTap: () {
                  context.bloc<ProfileCubit>().addUser(user);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 12.h, bottom: 24.h),
                child: EmmaBorderButton(
                  color: Colors.white,
                  text: 'Отказаться',
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
