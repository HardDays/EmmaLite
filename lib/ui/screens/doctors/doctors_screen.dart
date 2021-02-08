import 'package:emma_mobile/bloc/doctors_screen/doctors_bloc.dart';
import 'package:emma_mobile/bloc/doctors_screen/doctors_state.dart';
import 'package:emma_mobile/models/doctor/doctor.dart';
import 'package:emma_mobile/ui/components/app_bar/emm_app_bar.dart';
import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/measurement/default_container.dart';
import 'package:emma_mobile/ui/screens/doctors/new_doctor_screen.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class DoctorsScreen extends StatelessWidget {
  final bool returnDoctor;

  const DoctorsScreen({Key key, this.returnDoctor = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<DoctorsBloc>();
    final _slidableController = SlidableController();
    return Provider.value(
      value: _slidableController,
      child: Scaffold(
        body: Column(
          children: [
            EmmaAppBar(
              title: 'Мои врачи',
              trailing: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => NewDoctorScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: AppIcons.plus(),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<DoctorsBloc, DoctorsState>(
                builder: (_, __) {
                  if (bloc.doctors.isEmpty) {
                    return _EmptyDoctors();
                  }
                  return ListView.separated(
                    itemCount: bloc.doctors.length,
                    itemBuilder: (_, i) {
                      return GestureDetector(
                        onTap: () {
                          if (returnDoctor) {
                            Navigator.of(context).pop(bloc.doctors[i]);
                          }
                        },
                        behavior: HitTestBehavior.opaque,
                        child: IgnorePointer(
                          ignoring: returnDoctor,
                          child: _Doctor(doctor: bloc.doctors[i]),
                        ),
                      );
                    },
                    separatorBuilder: (_, __) {
                      return Padding(padding: EdgeInsets.only(top: 8.h));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Doctor extends StatelessWidget {
  final Doctor doctor;

  const _Doctor({Key key, this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(doctor.id.toString()),
      actionPane: const SlidableScrollActionPane(),
      controller: Provider.of<SlidableController>(context),
      actionExtentRatio: 0.25,
      secondaryActions: [
        GestureDetector(
          onTap: () {
            context.bloc<DoctorsBloc>().deleteDoctor(doctor);
          },
          child: DecoratedBox(
            decoration: const BoxDecoration(
                color: AppColors.cFF3B30,
                borderRadius:
                    BorderRadius.horizontal(left: Radius.circular(4))),
            child: Center(
              child: AppIcons.trash(),
            ),
          ),
        ),
      ],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: DefaultContainer(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => NewDoctorScreen(doctor: doctor),
              ),
            );
          },
          minHeight: 68.h,
          child: Padding(
            padding: EdgeInsets.only(top: 16.h, bottom: 13.h, left: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 232.w,
                          child: Text(
                            doctor.name,
                            style: AppTypography.font16.copyWith(
                              color: AppColors.c3B4047,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 2.h),
                          child: Text(
                            doctor.email,
                            style: AppTypography.font12.copyWith(
                              color: AppColors.c9B9B9B,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: AppIcons.arrowRight(),
                    )
                  ],
                ),
                if (doctor.comment.isNotEmpty) ...[
                  Padding(
                    padding: EdgeInsets.only(top: 12.h, bottom: 8.h),
                    child: Container(
                      width: 246.w,
                      height: 1.h,
                      color: AppColors.cEBEEF3,
                    ),
                  ),
                  SizedBox(
                    width: 248.w,
                    child: Text(
                      doctor.comment,
                      style: AppTypography.font12.copyWith(
                        color: AppColors.c9B9B9B,
                      ),
                    ),
                  )
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyDoctors extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 60.h),
          child: Container(
            width: 140.w,
            height: 140.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.cFFFFFF,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.08),
                  offset: Offset(0, 2),
                  blurRadius: 4,
                )
              ],
            ),
            child: Center(
              child: AppIcons.doctors(size: 64.w),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 24.h, bottom: 32.h),
          child: SizedBox(
            width: 296.w,
            child: Text(
              'Здесь вы можете сохранить контакты своих\nврачей, чтобы быстрее отправлять им\nотчеты.',
              style: AppTypography.font14.copyWith(
                color: AppColors.c9B9B9B,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        EmmaFilledButton(
          width: 288.w,
          title: 'Добавить врача',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => NewDoctorScreen(),
              ),
            );
          },
        )
      ],
    );
  }
}
