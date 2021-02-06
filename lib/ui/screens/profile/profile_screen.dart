import 'package:emma_mobile/bloc/profile/profile_cubit.dart';
import 'package:emma_mobile/bloc/profile/profile_state.dart';
import 'package:emma_mobile/bloc/profile_screen/profile_screen_bloc.dart';
import 'package:emma_mobile/bloc/profile_screen/profile_screen_state.dart';
import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/profile/fields.dart';
import 'package:emma_mobile/ui/components/profile/image.dart';
import 'package:emma_mobile/ui/screens/profile/new_profile_screen.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<ProfileCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (_, __) {
        if (bloc.currentUser.isEmpty) {
          return Scaffold(
            body: BlocProvider(
              create: (_) => ProfileScreenBloc(),
              child: _EmptyProfile(),
            ),
          );
        }
        return Provider.value(
          value: bloc.currentUser,
          child: _CurrentProfile(),
        );
      },
    );
  }
}

class _CurrentProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<ProfileCubit>();
    return Column(
      children: [
        const EmmaAppBar(title: 'Профиль'),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 32.h, bottom: 12.h),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        Opacity(
                          opacity: 0,
                          child: Container(
                            width: 44.w,
                            height: 44.w,
                            margin: EdgeInsets.only(right: 24.w),
                            decoration: profileImageDecoration(
                              color: AppColors.cFFFFFF,
                            ),
                            child: Center(
                              child: AppIcons.settings(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 120.w,
                          child: ListView.separated(
                            itemCount: bloc.users.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, i) {
                              return ProfileImage(
                                size: 120.w,
                                url: bloc.users[i].photo,
                              );
                            },
                            separatorBuilder: (_, __) {
                              return Padding(
                                padding: EdgeInsets.only(left: 16.w),
                              );
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => NewProfileScreen(),
                              ),
                            );
                          },
                          child: Container(
                            width: 44.w,
                            height: 44.w,
                            margin: EdgeInsets.only(left: 24.w),
                            decoration: profileImageDecoration(
                              color: AppColors.cFFFFFF,
                            ),
                            child: Center(
                              child: AppIcons.plus(
                                size: 16.w,
                                color: AppColors.cA0B4CB,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IgnorePointer(
                  ignoring: true,
                  child: ProfileFields(),
                ),
                Padding(padding: EdgeInsets.only(top: 56.h)),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _EmptyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<ProfileScreenBloc>();
    return BlocBuilder<ProfileScreenBloc, ProfileScreenState>(
      builder: (_, __) {
        return Column(
          children: [
            const EmmaAppBar(title: 'Профиль'),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                physics: const BouncingScrollPhysics(),
                child: Provider.value(
                  value: bloc.user,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 24.h),
                        child: ProfilePickImage(),
                      ),
                      if (bloc.user.photo.isEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: 16.h),
                          child: Text(
                            'Вы можете добавить свое фото. Оно будет отображаться только в отчете.',
                            style: AppTypography.font14.copyWith(
                              color: AppColors.c9B9B9B,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ProfileFields(),
                      EmmaFilledButton(
                        title: 'Сохранить',
                        onTap: () {
                          context.bloc<ProfileCubit>().addUser(bloc.user);
                        },
                        isActive: bloc.user.canSave,
                      ),
                      KeyboardVisibilityBuilder(
                        builder: (_, isKeyboardVisible) {
                          return Padding(
                            padding: EdgeInsets.only(
                              top: isKeyboardVisible ? 24.h : 80.h,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}