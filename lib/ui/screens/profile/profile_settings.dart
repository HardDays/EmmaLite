import 'package:emma_mobile/bloc/app_settings/app_settings_bloc.dart';
import 'package:emma_mobile/bloc/app_settings/app_settings_state.dart';
import 'package:emma_mobile/bloc/profile/profile_cubit.dart';
import 'package:emma_mobile/bloc/profile/profile_state.dart';
import 'package:emma_mobile/models/user/user.dart';
import 'package:emma_mobile/ui/components/app_bar/small_app_bar.dart';
import 'package:emma_mobile/ui/components/buttons/emma_border_button.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/measurement/default_container.dart';
import 'package:emma_mobile/ui/components/profile/image.dart';
import 'package:emma_mobile/ui/components/profile/profile_help_widget.dart';
import 'package:emma_mobile/ui/screens/profile/confirm_delete.dart';
import 'package:emma_mobile/ui/screens/profile/new_profile_screen.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reorderables/reorderables.dart';

class ProfileSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<ProfileCubit>();
    return Scaffold(
      backgroundColor: AppColors.cF5F7FA,
      body: Column(
        children: [
          SmallAppBar(
            title: 'profileManagementNavBarTitle'.tr,
            leading: AppIcons.chevronLeft(),
          ),
          _ProfileInfoTip(),
          Expanded(
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (_, __) {
                final List<Widget> children = [];
                for (var i in bloc.users)
                  children.add(_Profile(user: i, key: Key(i.id.toString())));
                return CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    ReorderableSliverList(
                      delegate: ReorderableSliverChildBuilderDelegate(
                        (_, index) => _Profile(
                          user: bloc.users[index],
                          key: Key(bloc.users[index].id.toString()),
                        ),
                        childCount: bloc.users.length,
                      ),
                      onReorder: (i, j) {
                        bloc.changeIndex(current: i, previous: j);
                      },
                      buildDraggableFeedback: (_, __, child) => Padding(
                        padding: EdgeInsets.only(left: 16.w),
                        child: Material(
                          child: child,
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.h, bottom: 24.h),
            child: EmmaBorderButton(
              text: 'Добавить профиль',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => NewProfileScreen(),
                  ),
                );
              },
            ),
          ),
        ],
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
        if (bloc.appSettings.showProfileSettingsHelp) {
          return const SizedBox();
        }
        return ProfileHelpWidget(
          text: 'addProfiles'.tr,
          closeTap: bloc.setShowProfileSettingsHelp,
        );
      },
    );
  }
}

class _Profile extends StatelessWidget {
  final User user;

  const _Profile({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 12.h),
        child: DefaultContainer(
          minHeight: 80.h,
          maxHeight: 80.h,
          width: 288.w,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 12.w),
                  child: SmallProfileImage(user: user),
                ),
                SizedBox(
                  width: 155.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${user.firstName} ${user.lastName}',
                        style: AppTypography.font16.copyWith(
                          color: AppColors.c3B4047,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: Text(
                          user.statusWithDefault,
                          style: AppTypography.font14.copyWith(
                            color: AppColors.c9B9B9B,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                if (user.status.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ConfirmDelete(user: user),
                        ),
                      );
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
                      child: AppIcons.trash(
                        color: AppColors.cA0B4CB.withOpacity(0.5),
                        size: 16.w,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
