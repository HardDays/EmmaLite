import 'dart:io';

import 'package:emma_mobile/bloc/assign/assign_bloc.dart';
import 'package:emma_mobile/bloc/measurement/measurement_cubit.dart';
import 'package:emma_mobile/bloc/profile/profile_cubit.dart';
import 'package:emma_mobile/bloc/report_screen/report_screen_bloc.dart';
import 'package:emma_mobile/bloc/report_screen/report_screen_state.dart';
import 'package:emma_mobile/models/assignment/tasks.dart';
import 'package:emma_mobile/models/doctor/doctor.dart';
import 'package:emma_mobile/models/pdf_models.dart';
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
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:share/share.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReportScreenBloc(),
      child: Scaffold(
        backgroundColor: AppColors.cF5F7FA,
        body: Column(
          children: [
            SmallAppBar(
              title: 'Новый отчет',
              leadingText: 'titleCancelButton'.tr,
            ),
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
                    title: 'startDateText'.tr,
                    hintText: 'startDateText'.tr,
                    haveDecoration: false,
                    dateFormat: DateFormat('dd.MM.yyyy'),
                    value: bloc.report.startDate,
                    onChange: bloc.setStartDate,
                  ),
                  ProfileDivider(),
                  DateTimeTextField(
                    title: 'endDateText'.tr,
                    hintText: 'endDateText'.tr,
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
                        label: 'Actions'.tr,
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
                          label: 'recipientsMail'.tr,
                          type: TextInputType.text,
                          formatRegExp: RegExp(Constants.emailRegex),
                          value: bloc.report.email ?? '',
                          onChange: bloc.setEmail,
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
                label: 'titleComment'.tr,
                haveFormatter: false,
                type: TextInputType.text,
                onChange: bloc.setComment,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24.h),
              child: EmmaFilledButton(
                title: 'sendButtonText'.tr,
                isActive: bloc.canSave,
                onTap: () async {

                  final pdf = pw.Document();
                  final user = context.bloc<ProfileCubit>().currentUser;

                  final assignBloc = context.bloc<AssignBloc>();
                  final measurBloc = context.bloc<MeasurementCubit>();
                  final report = bloc.report;
                  final List<RunTask> tasks = [];
                  if (report.startDate.isBefore(report.endDate)) {
                    for (var i = 0; i < report.difference; i++) {
                      tasks.addAll(
                        assignBloc.getTaskInDay(
                          date: report.startDate.add(Duration(days: i)),
                        ),
                      );
                    }
                  }

                  File file;
                  List<Widget> widgets = [];
                  List<PageWidget> pageWidgets = [];
                  int index = 0;
                  bool isFirstWidget = true;
                  while (index < report.difference) {
                    final currentDay =
                        report.startDate.add(Duration(days: index));
                    final inDayTasks = tasks
                        .where((e) => e.dateTime.isInDay(currentDay))
                        .toList();
                    final measList = measurBloc.getForDateRange(
                      start: report.startDate,
                      end: report.endDate,
                    );
                    final pageWidget = await WidgetImage.create(
                      measurementList: measList,
                      assignBloc: assignBloc,
                      tasks: tasks,
                      user: user,
                      report: report,
                      previousPageLastDay: pageWidgets.isEmpty
                          ? null
                          : pageWidgets.last.dayWidgets.last,
                      isFirst: isFirstWidget,
                    );
                    if (pageWidget.dayWidgets.isNotEmpty || isFirstWidget) {
                      pageWidgets.add(pageWidget);
                      widgets.add(pageWidget.widget);
                    }
                    isFirstWidget = false;
                    index = pageWidget.dayWidgets.last.day;
                    if (pageWidget.dayWidgets.last.endTask ==
                            inDayTasks.length &&
                        index == report.difference - 1) {
                      break;
                    }
                  }

                  isFirstWidget = true;
                  for (var i in pageWidgets) {
                    final bytes = await CreatePdf.create(
                      measurementList: measurBloc.getForDateRange(
                        start: report.startDate,
                        end: report.endDate,
                      ),
                      assignBloc: assignBloc,
                      tasks: tasks,
                      user: user,
                      report: report,
                      pageWidget: i,
                      isFirst: isFirstWidget,
                    );
                    isFirstWidget = false;
                    pdf.addPage(
                      pw.Page(
                        pageFormat: PdfPageFormat.a4,
                        build: (_) {
                          return bytes;
                        },
                      ),
                    );
                  }

                  final dir = await getApplicationSupportDirectory();
                  file = File(
                      '${dir.path}/${'reportSubject'.tr} ${user.lastName}.pdf');
                  if (!file.existsSync()) {
                    file.createSync(recursive: true);
                  }
                  final fileBytes = await pdf.save();
                  file.writeAsBytesSync(fileBytes);

                  Share.shareFiles([file.path]);

                  // final Email email = Email(
                  //   recipients: [
                  //     report.reportType is SelfReportType
                  //         ? user.email
                  //         : report.email
                  //   ],
                  //   attachmentPaths: [file.path],
                  // );
                  //
                  // await FlutterEmailSender.send(email);
                },
              ),
            )
          ],
        );
      },
    );
  }
}

