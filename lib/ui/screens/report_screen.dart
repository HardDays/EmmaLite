import 'package:emma_mobile/bloc/report_screen/report_screen_bloc.dart';
import 'package:emma_mobile/bloc/report_screen/report_screen_state.dart';
import 'package:emma_mobile/models/doctor/doctor.dart';
import 'package:emma_mobile/models/report/report.dart';
import 'package:emma_mobile/ui/components/app_bar/small_app_bar.dart';
import 'package:emma_mobile/ui/components/bottom_sheet.dart';
import 'package:emma_mobile/ui/components/buttons/emma_filled_button.dart';
import 'package:emma_mobile/ui/components/icons.dart';
import 'package:emma_mobile/ui/components/measurement/date_time_text_field.dart';
import 'package:emma_mobile/ui/components/measurement/default_container.dart';
import 'package:emma_mobile/ui/components/measurement/int_text_field.dart';
import 'package:emma_mobile/ui/components/profile/fields.dart';
import 'package:emma_mobile/ui/screens/doctors/doctors_screen.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReportScreenBloc(),
      child: Scaffold(
        body: Column(
          children: [
            const SmallAppBar(title: 'Новый отчет', leadingText: 'Отменить'),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: 16.h,
                  bottom: 67.h,
                  left: 16.w,
                  right: 16.w,
                ),
                physics: const BouncingScrollPhysics(),
                child: _Fields(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Fields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<ReportScreenBloc>();
    return BlocBuilder<ReportScreenBloc, ReportScreenState>(
      builder: (_, __) {
        return Column(
          children: [
            DefaultContainer(
              child: Column(
                children: [
                  DateTimeTextField(
                    title: 'Дата начала',
                    hintText: 'Дата начала',
                    haveDecoration: false,
                    dateFormat: DateFormat('dd.MM.yyyy'),
                    value: bloc.report.startDate,
                    onChange: bloc.setStartDate,
                  ),
                  ProfileDivider(),
                  DateTimeTextField(
                    title: 'Дата окончания',
                    hintText: 'Дата окончания',
                    value: bloc.report.endDate,
                    dateFormat: DateFormat('dd.MM.yyyy'),
                    haveDecoration: false,
                    onChange: bloc.setEndDate,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: DefaultContainer(
                onTap: () async {
                  final res = await showDefaultPicker(
                    context: context,
                    values: reportTypes.map((e) => e.title).toList(),
                    pickerTitle: 'Действия',
                  );
                  if (res != null) {
                    bloc.setType(reportTypes[res]);
                  }
                },
                child: Row(
                  children: [
                    Expanded(
                      child: InputTextField(
                        label: 'Действие с отчетом',
                        enable: false,
                        value: bloc.report.reportType?.title,
                        haveFormatter: false,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: AppIcons.arrowRight(),
                    )
                  ],
                ),
              ),
            ),
            if (bloc.report.reportType is! SelfReportType)
              Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: DefaultContainer(
                  child: Row(
                    children: [
                      Expanded(
                        child: InputTextField(
                          label: 'Почта получателя',
                          type: TextInputType.text,
                          formatRegExp: RegExp(Constants.emailRegex),
                          value: bloc.report.email ?? '',
                          haveFormatter: false,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final res = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => DoctorsScreen(
                                returnDoctor: true,
                              ),
                            ),
                          );
                          if (res is Doctor) {
                            bloc.setEmail(res.email);
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Container(
                            width: 44.h,
                            height: 44.h,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.cEBEEF3,
                            ),
                            child: Center(child: AppIcons.doctors()),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            DefaultContainer(
              child: InputTextField(
                label: 'Комментарий (необязательно)',
                haveFormatter: false,
                type: TextInputType.text,
                onChange: bloc.setComment,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24.h),
              child: EmmaFilledButton(
                title: 'Отправить',
                isActive: bloc.canSave,
                onTap: () {},
              ),
            )
          ],
        );
      },
    );
  }
}
