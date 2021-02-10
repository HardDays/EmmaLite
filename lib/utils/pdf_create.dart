import 'dart:io';
import 'dart:typed_data';

import 'package:emma_mobile/bloc/assign/assign_bloc.dart';
import 'package:emma_mobile/models/assignment/assign_type.dart';
import 'package:emma_mobile/models/assignment/tasks.dart';
import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/models/report/report.dart';
import 'package:emma_mobile/models/user/user.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

abstract class CreatePdf {
  static Future<Uint8List> _loadImage(String path) async {
    return (await rootBundle.load(path)).buffer.asUint8List();
  }

  static Future<Widget> create({
    User user,
    Report report,
    List<RunTask> tasks,
    AssignBloc assignBloc,
    List<Measurement> measurementList,
  }) async {
    const iconPath = 'assets/pdf_icons/';
    final fontData =
        await rootBundle.load('assets/fonts/SFProDisplay-Regular.ttf');
    final calendar = await _loadImage('${iconPath}calendar.png');
    final genderPath = user.gender == Gender.female
        ? '${iconPath}no_photo_woman.png'
        : '${iconPath}no_photo_man.png';
    final noPhoto = user.photo.isEmpty
        ? await _loadImage(genderPath)
        : File(user.photo).readAsBytesSync();

    final gender = await _loadImage('${iconPath}gender_male.png');
    final height = await _loadImage('${iconPath}height.png');
    final weight = await _loadImage('${iconPath}weight.png');
    final done = await _loadImage('${iconPath}done.png');
    final donePart = await _loadImage('${iconPath}done_part.png');
    final notCompleted = await _loadImage('${iconPath}not_completed.png');
    final heart = await _loadImage('${iconPath}heart.png');
    final ttf = Font.ttf(fontData);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 32, bottom: 8),
          child: Text(
            'reportSubject'.tr,
            style: TextStyle(
              color: PdfColor.fromInt(Colors.black.value),
              font: ttf,
              fontSize: 24,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Text(
            'reportDescription'.tr,
            style: TextStyle(
              color: PdfColor.fromInt(Colors.black.value),
              font: ttf,
              fontSize: 14,
            ),
          ),
        ),
        _topDates(
          calendar: calendar,
          report: report,
          ttf: ttf,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: _nameRow(
            noPhoto: noPhoto,
            height: height,
            weight: weight,
            gender: gender,
            user: user,
            ttf: ttf,
          ),
        ),
        if (report.comment != null && report.comment.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Text(
                  'reportComment'.tr,
                  style: TextStyle(
                    font: ttf,
                    fontWeight: FontWeight.bold,
                    color: PdfColor.fromHex('9B9B9B'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  report.comment,
                  style: TextStyle(
                    font: ttf,
                    fontSize: 8,
                  ),
                ),
              )
            ],
          ),
        Padding(
          padding: const EdgeInsets.only(top: 44),
        ),
        ListView.separated(
          itemCount: report.difference,
          itemBuilder: (_, i) {
            final currentDay = report.startDate.add(Duration(days: i));
            final inDayTasks =
                tasks.where((e) => e.dateTime.isInDay(currentDay)).toList();
            inDayTasks.sort((i, j) => i.dateTime.compareTo(j.dateTime));
            final inDayMeasurement = measurementList
                .where((e) => e.dateTime.isInDay(currentDay))
                .toList();
            return SizedBox(
              width: 530,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      DateFormat('dd.MM.yyyy').format(currentDay),
                      style: TextStyle(
                        font: ttf,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '${'prescriptionsTitleLabel'.tr}: ${inDayTasks.where((e) => e.completed).length}/${inDayTasks.length}',
                          style: TextStyle(
                            font: ttf,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'mainTitleMeasurements'.tr,
                          style: TextStyle(
                            font: ttf,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: const EdgeInsets.only(top: 16)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemCount: inDayTasks.length,
                          itemBuilder: (_, i) {
                            final task = inDayTasks[i];
                            return _task(
                              done: done,
                              donePart: donePart,
                              notCompleted: notCompleted,
                              task: task,
                              assignBloc: assignBloc,
                              ttf: ttf,
                            );
                          },
                          separatorBuilder: (_, __) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 12),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemCount: inDayMeasurement.length,
                          itemBuilder: (_, i) {
                            final measurement = inDayMeasurement[i];
                            return _measurement(
                              measurement: measurement,
                              ttf: ttf,
                            );
                          },
                          separatorBuilder: (_, __) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 12),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (_, __) {
            return Padding(padding: const EdgeInsets.only(top: 40));
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Row(
            children: [
              Image(MemoryImage(heart)),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  'EMMA Lite',
                  style: TextStyle(
                    font: ttf,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _measurement({
    Font ttf,
    Measurement measurement,
  }) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 30,
              child: Text(
                DateFormat.Hm().format(measurement.dateTime),
                style: TextStyle(
                  font: ttf,
                  fontSize: 10,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                measurement.longTitle.tr,
                style: TextStyle(
                  fontSize: 10,
                  font: ttf,
                ),
              ),
            ),
            Spacer(),
            Text(
              measurement.value(),
              style: TextStyle(
                fontSize: 10,
                font: ttf,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, left: 46),
          child: Row(
            children: [
              Text(
                '',
                style: TextStyle(
                  font: ttf,
                  fontSize: 8,
                  color: PdfColor.fromHex('9B9B9B'),
                ),
              ),
              Spacer(),
              Text(
                measurement.units.tr,
                style: TextStyle(
                  font: ttf,
                  fontSize: 8,
                  color: PdfColor.fromHex('9B9B9B'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _task({
    Font ttf,
    RunTask task,
    Uint8List notCompleted,
    Uint8List donePart,
    Uint8List done,
    AssignBloc assignBloc,
  }) {
    Uint8List photo;
    if (!task.completed) {
      photo = notCompleted;
    } else if (task.completedDate.isAfter(task.dateTime)) {
      photo = donePart;
    } else {
      photo = done;
    }
    final assign = assignBloc.getAssignById(task.assignId);
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(MemoryImage(photo), width: 16, height: 16),
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 4,
              ),
              child: SizedBox(
                width: 50,
                child: Text(
                  DateFormat.Hm().format(task.dateTime),
                  style: TextStyle(
                    font: ttf,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 183,
              child: Text(
                '${task.assignName}${assign.countForPDFForTask(task)}',
                style: TextStyle(
                  font: ttf,
                  fontSize: 10,
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 4),
          child: Row(
            children: [
              SizedBox(
                width: 54,
                child: Builder(
                  builder: (_) {
                    if (!task.completed ||
                        (task.completed &&
                            task.completedDate.isBefore(task.dateTime))) {
                      return SizedBox();
                    }
                    final now = DateTime.now();
                    final dif = now.difference(task.completedDate);
                    final minutes = dif.inMinutes - (dif.inHours * 60);
                    final hour = dif.inHours;
                    return Text(
                      '+$hourч ${minutes == 0 ? '' : '$minutes${'minText'.tr}'}',
                      style: TextStyle(
                        font: ttf,
                        fontSize: 8,
                        color: PdfColor.fromHex('9B9B9B'),
                      ),
                    );
                  },
                ),
              ),
              Text(
                '${assign.type.title}, ${assign.type is OtherAssignType ? 'самоназначение' : assign.doctorName}',
                style: TextStyle(
                  font: ttf,
                  // fontFamily: AppTypography.textStyle,
                  fontSize: 8,
                  color: PdfColor.fromHex('9B9B9B'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _nameRow({
    Uint8List noPhoto,
    Uint8List gender,
    Uint8List height,
    Uint8List weight,
    User user,
    Font ttf,
  }) {
    final years = DateTime.now().year - user.date.year;
    return Container(
      width: 530,
      height: 92,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: PdfColor.fromHex('CFD9DF')),
      ),
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 60,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: ClipRRect(
                horizontalRadius: 30,
                verticalRadius: 30,
                child: Image(
                  MemoryImage(noPhoto),
                  width: 60,
                  height: 60,
                  fit: BoxFit.fill,
                )
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.firstName ?? ''} ${user.lastName ?? ''}',
                  style: TextStyle(
                    font: ttf,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    '${DateFormat('dd.MM.yyyy').format(user.date)}, $years ${years.getPluralYears}',
                    style: TextStyle(
                      font: ttf,
                    ),
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Image(MemoryImage(gender), width: 12, height: 12),
                    Padding(
                      padding: const EdgeInsets.only(left: 4, right: 24),
                      child: Text(
                        user.gender == null
                            ? ''
                            : user.gender == Gender.male
                                ? 'maleButtonTitle'.tr
                                : 'femaleButtonTitle'.tr,
                        style: TextStyle(
                          fontSize: 8,
                          font: ttf,
                        ),
                      ),
                    ),
                    Image(MemoryImage(weight), width: 12, height: 12),
                    Padding(
                      padding: const EdgeInsets.only(left: 4, right: 24),
                      child: Text(
                        '${user.weight} ${'weightUnit'.tr}',
                        style: TextStyle(
                          fontSize: 8,
                          font: ttf,
                        ),
                      ),
                    ),
                    Image(MemoryImage(height), width: 12, height: 12),
                    Padding(
                      padding: const EdgeInsets.only(left: 4, right: 24),
                      child: Text(
                        '${user.height} см',
                        style: TextStyle(
                          fontSize: 8,
                          font: ttf,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Spacer(),
            Text(
              user.phone ?? '',
              style: TextStyle(
                font: ttf,
                fontSize: 10,
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget _topDates({Uint8List calendar, Report report, Font ttf}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(MemoryImage(calendar), width: 16, height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('dd.MM.yyyy').format(report.startDate),
                style: TextStyle(
                  font: ttf,
                  fontSize: 10,
                ),
              ),
              Text(
                'startDateText'.tr,
                style: TextStyle(
                  font: ttf,
                  fontSize: 10,
                  color: PdfColor.fromHex('9B9B9B'),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 348,
          height: 20,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                bottom: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 8,
                      width: 1,
                      color: PdfColor.fromHex('CFD9DF'),
                    ),
                    Container(
                      height: 1,
                      width: 346,
                      color: PdfColor.fromHex('CFD9DF'),
                    ),
                    Container(
                      height: 8,
                      width: 1,
                      color: PdfColor.fromHex('CFD9DF'),
                    ),
                  ],
                ),
              ),
              Text(
                '${report.difference} ${report.difference.getPluralDays}',
                style: TextStyle(
                  font: ttf,
                  fontSize: 10,
                  color: PdfColor.fromInt(Colors.black.value),
                ),
              )
            ],
          ),
        ),
        Padding(padding: const EdgeInsets.only(left: 16)),
        Image(MemoryImage(calendar), width: 16, height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('dd.MM.yyyy').format(report.endDate),
                style: TextStyle(
                  font: ttf,
                  fontSize: 10,
                ),
              ),
              Text(
                'Дата конца',
                style: TextStyle(
                  font: ttf,
                  fontSize: 10,
                  color: PdfColor.fromHex('9B9B9B'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
