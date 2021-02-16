import 'package:emma_mobile/bloc/profile/profile_cubit.dart';
import 'package:emma_mobile/bloc/profile_screen/profile_screen_bloc.dart';
import 'package:emma_mobile/bloc/profile_screen/profile_screen_state.dart';
import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/ui/components/profile/fields.dart';
import 'package:emma_mobile/ui/components/profile/image.dart';
import 'package:emma_mobile/ui/screens/first_open_screens/secure_data_screen.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class FirstOpenCreateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        backgroundColor: AppColors.cF5F7FA,
        body: Column(
          children: [
            EmmaAppBar(title: 'createNewProfileNavBarTitle'.tr),
            Expanded(
              child: BlocProvider(
                create: (_) => ProfileScreenBloc(),
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
                Padding(
                  padding: EdgeInsets.only(top: 24.h, bottom: 12.h),
                  child: EmmaFilledButton(
                    title: 'saveButtonText'.tr,
                    onTap: () {
                      context.bloc<ProfileCubit>().addUser(bloc.user);
                      Toast.show('saveData'.tr);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => SecureDataScreen(),
                        ),
                      );
                    },
                    isActive: bloc.canSave,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => SecureDataScreen(),
                      ),
                    );
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 12.h,
                      bottom: 16.h,
                      left: 16.w,
                      right: 16.w,
                    ),
                    child: Text(
                      'Сделаю позже',
                      style: AppTypography.font14.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.c00ACE3,
                      ),
                    ),
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
