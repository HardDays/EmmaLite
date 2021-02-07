import 'package:emma_mobile/bloc/app_settings/app_settings_bloc.dart';
import 'package:emma_mobile/bloc/app_settings/app_settings_state.dart';
import 'package:emma_mobile/bloc/assign/assign_bloc.dart';
import 'package:emma_mobile/bloc/doctors_screen/doctors_bloc.dart';
import 'package:emma_mobile/bloc/measurement/measurement_cubit.dart';
import 'package:emma_mobile/bloc/profile/profile_cubit.dart';
import 'package:emma_mobile/bloc/profile/profile_state.dart';
import 'package:emma_mobile/bloc/profile_screen/profile_screen_bloc.dart';
import 'package:emma_mobile/bloc/profile_screen/profile_screen_state.dart';
import 'package:emma_mobile/models/user/user.dart';
import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/measurement/default_container.dart';
import 'package:emma_mobile/ui/components/measurement/int_text_field.dart';
import 'package:emma_mobile/ui/components/profile/fields.dart';
import 'package:emma_mobile/ui/components/profile/image.dart';
import 'package:emma_mobile/ui/screens/profile/new_profile_screen.dart';
import 'package:emma_mobile/ui/screens/profile/profile_settings.dart';
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
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 32.h),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 44.w),
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: [
                            Opacity(
                              opacity: bloc.users.length == 1 ? 0 : 1,
                              child: GestureDetector(
                                onTap: () {
                                  if (bloc.users.length != 1) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => ProfileSettings(),
                                      ),
                                    );
                                  }
                                },
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
                            ),
                            SizedBox(
                              height: 132.w,
                              child: ListView.separated(
                                itemCount: bloc.users.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (_, i) {
                                  return GestureDetector(
                                    onTap: () {
                                      context.bloc<ProfileCubit>().setUser(
                                            bloc.users[i],
                                          );
                                      context.bloc<MeasurementCubit>().reload();
                                      context.bloc<DoctorsBloc>().reload();
                                      context.bloc<AssignBloc>().reload();
                                    },
                                    child: ProfileImage(
                                      size: 120.w,
                                      user: bloc.users[i],
                                    ),
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: IgnorePointer(
                        ignoring: true,
                        key: ValueKey(context.watch<User>().id.toString()),
                        child: Column(
                          children: [
                            ProfileFields(),
                            DefaultContainer(
                              child: InputTextField(
                                label: 'Статус',
                                initialValue:
                                    bloc.currentUser.statusWithDefault,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 80.h)),
                  ],
                ),
                _Arrow()
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _Arrow extends StatefulWidget {
  @override
  __ArrowState createState() => __ArrowState();
}

class __ArrowState extends State<_Arrow> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      value: 0,
    )..addListener(_listener);
    super.initState();
  }

  void _listener() {
    setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  bool _update = false;

  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<AppSettingsBloc>();
    return BlocBuilder<AppSettingsBloc, AppSettingsState>(
      builder: (_, __) {
        if (!bloc.appSettings.showProfilePlusHelp && !_update) {
          Future.delayed(const Duration(milliseconds: 100), () {
            _update = true;
            bloc.setShowProfilePlusHelp();
            _controller.forward();
          });
        }
        return Positioned(
          top: 32.h + 90.w + 12.h * (1 - _controller.value),
          right: 4.w,
          child: Visibility(
            visible: !bloc.appSettings.showProfilePlusHelp,
            child: Opacity(
              opacity: _controller.value,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  SizedBox(width: 140.w, height: 125.h),
                  Positioned(
                    top: 0,
                    right: 20.w,
                    child: CustomPaint(
                      size: Size(34.w, 20.h),
                      painter: _ArrowPointer(),
                    ),
                  ),
                  Container(
                    width: 140.w,
                    height: 105.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColors.c3B4047.withOpacity(0.9),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 11.h),
                          child: Text(
                            'Нажмите на “+”, чтобы добавить семейный профиль',
                            style: AppTypography.font12.copyWith(
                              color: AppColors.cFFFFFF,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => setState(() {}),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 8.h,
                              bottom: 6.h,
                              left: 16.w,
                              right: 16.w,
                            ),
                            child: Text(
                              'Ясно',
                              style: AppTypography.font12.copyWith(
                                color: AppColors.c00ACE3,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ArrowPointer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.c3B4047.withOpacity(0.9)
      ..strokeWidth = 5
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final p = 3.w;
    final r = 3.h;
    path.moveTo(0, size.height);
    path.lineTo(size.width / 2 - p, r);
    path.quadraticBezierTo(size.width / 2, 0, size.width / 2 + p, r);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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
                      ProfilePickImage(),
                      Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: ProfileFields(),
                      ),
                      EmmaFilledButton(
                        title: 'Сохранить',
                        onTap: () {
                          context.bloc<ProfileCubit>().addUser(bloc.user);
                        },
                        isActive: bloc.canSave,
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
