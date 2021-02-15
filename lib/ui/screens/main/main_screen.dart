import 'package:emma_mobile/bloc/measurement/measurement_cubit.dart';
import 'package:emma_mobile/bloc/measurement/measurement_state.dart';
import 'package:emma_mobile/bloc/profile/profile_cubit.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/routing/navigator.dart';
import 'package:emma_mobile/ui/screens/main/assign_data.dart';
import 'package:emma_mobile/ui/screens/main/empty_block.dart';
import 'package:emma_mobile/ui/screens/main/measurement_horizontal_list_item.dart';
import 'package:emma_mobile/ui/screens/measurement/select_measurement.dart';
import 'package:emma_mobile/utils/date_utils.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<MeasurementCubit>();
    final profileBloc = context.bloc<ProfileCubit>();
    return Scaffold(
      backgroundColor: AppColors.cF5F7FA,
      body: BlocBuilder<MeasurementCubit, MeasurementState>(
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SafeArea(
                        bottom: false,
                        child: Padding(
                          padding: EdgeInsets.only(top: 24.h, bottom: 16.h),
                          child: Text(
                            '${greetingStringBasedOn(DateTime.now())}${profileBloc.currentUser.isEmpty ? '' : ', ${profileBloc.currentUser.firstName}'}',
                            style: AppTypography.font20.copyWith(
                              color: AppColors.c000000,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'titleNearestPrescriptions'.tr,
                        style: AppTypography.font16.copyWith(
                          color: AppColors.c3B4047,
                        ),
                      ),
                      AssignData(),
                      Padding(
                        padding: EdgeInsets.only(bottom: 12.h, top: 24.h),
                        child: Text(
                          'Текущие измерения',
                          style: AppTypography.font16.copyWith(
                            color: AppColors.c3B4047,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (bloc.isEmptyData == true)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: EmptyBlockMain(
                      icon: AppIcons.measurementsInactive(),
                      title:
                          'Здесь будут показываться ваши\nпоследние значения по всем измерениям',
                      buttonTitle: 'addNewMeasurementLabel'.tr,
                      onTap: () => navigatorPush(
                        context,
                        SelectMeasurement(),
                      ),
                    ),
                  )
                else
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 90.h,
                      maxHeight: 120.h,
                    ),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemBuilder: (_, i) => MeasurementHorizontalListItem(
                        item: bloc.data[i],
                      ),
                      separatorBuilder: (_, __) => Padding(
                        padding: EdgeInsets.only(left: 8.w),
                      ),
                      itemCount: bloc.data.length,
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
