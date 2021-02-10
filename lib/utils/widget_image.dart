import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'dart:typed_data';

import 'package:emma_mobile/bloc/assign/assign_bloc.dart';
import 'package:emma_mobile/models/assignment/assign_type.dart';
import 'package:emma_mobile/models/assignment/tasks.dart';
import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/models/report/report.dart';
import 'package:emma_mobile/models/user/user.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' hide TextDirection;

abstract class WidgetImage {
  static Future<ui.Image> getImage({Widget widget}) async {
    final RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();

    final RenderView renderView = RenderView(
      window: null,
      child: RenderPositionedBox(
        alignment: Alignment.center,
        child: repaintBoundary,
      ),
      configuration: const ViewConfiguration(
        size: Size(568, 125000),
        devicePixelRatio: 1.0,
      ),
    );

    final PipelineOwner pipelineOwner = PipelineOwner();
    final BuildOwner buildOwner = BuildOwner();

    pipelineOwner.rootNode = renderView;
    renderView.prepareInitialFrame();

    final RenderObjectToWidgetElement<RenderBox> rootElement =
    await RenderObjectToWidgetAdapter<RenderBox>(
      container: repaintBoundary,
      child: Material(
        color: Colors.transparent,
        child: MediaQuery(
          data: MediaQueryData(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: widget,
          ),
        ),
      ),
    ).attachToRenderTree(buildOwner);

    await buildOwner.buildScope(rootElement);

    await buildOwner.buildScope(rootElement);
    await buildOwner.buildScope(rootElement);

    await Future.delayed(Duration(seconds: 1));

    await buildOwner.buildScope(rootElement);
    await buildOwner.buildScope(rootElement);
    await buildOwner.buildScope(rootElement);
    await buildOwner.buildScope(rootElement);
    await buildOwner.finalizeTree();

    pipelineOwner.requestVisualUpdate();
    await pipelineOwner.flushLayout();
    await pipelineOwner.flushCompositingBits();
    await pipelineOwner.flushPaint();

    final ui.Image image = await repaintBoundary.toImage();
    return image;
  }


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
    final noPhoto = await _loadImage('${iconPath}no_photo_man.png');

    final genderPath = user.gender == Gender.female
        ? '${iconPath}gender_female.png'
        : '${iconPath}gender_male.png';
    final gender = user.photo.isEmpty
        ? await _loadImage(genderPath)
        : File(user.photo).readAsBytesSync();
    final height = await _loadImage('${iconPath}height.png');
    final weight = await _loadImage('${iconPath}weight.png');
    final done = await _loadImage('${iconPath}done.png');
    final donePart = await _loadImage('${iconPath}done_part.png');
    final notCompleted = await _loadImage('${iconPath}not_completed.png');
    final heart = await _loadImage('${iconPath}heart.png');
    // final ttf = Font.ttf(fontData);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 32, bottom: 8),
          child: Text(
            'reportSubject'.tr,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: AppTypography.textStyle,
              fontSize: 24,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Text(
            'reportDescription'.tr,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: AppTypography.textStyle,
              fontSize: 14,
            ),
          ),
        ),
        _topDates(
          calendar: calendar,
          report: report,
          // ttf: ttf,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: _nameRow(
            noPhoto: noPhoto,
            height: height,
            weight: weight,
            gender: gender,
            user: user,
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
                  style: const TextStyle(
                    fontFamily: AppTypography.textStyle,
                    fontWeight: FontWeight.bold,
                    // color: PdfColor.fromHex('9B9B9B'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  report.comment,
                  style: const TextStyle(
                    fontFamily: AppTypography.textStyle,
                    fontSize: 8,
                  ),
                ),
              )
            ],
          ),
        const Padding(padding: EdgeInsets.only(top: 44)),
        ListView.separated(
          itemCount: report.difference,
          shrinkWrap: true,
          itemBuilder: (_, i) {
            final currentDay = report.startDate.add(Duration(days: i));
            final inDayTasks =
            tasks.where((e) => e.dateTime.isInDay(currentDay)).toList();
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
                      style: const TextStyle(
                        fontFamily: AppTypography.textStyle,
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
                          style: const TextStyle(
                            fontFamily: AppTypography.textStyle,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'mainTitleMeasurements'.tr,
                          style: const TextStyle(
                            fontFamily: AppTypography.textStyle,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 16)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemCount: inDayTasks.length,
                          shrinkWrap: true,
                          itemBuilder: (_, i) {
                            final task = inDayTasks[i];
                            return _task(
                              done: done,
                              donePart: donePart,
                              notCompleted: notCompleted,
                              task: task,
                              assignBloc: assignBloc,
                            );
                          },
                          separatorBuilder: (_, __) {
                            return const Padding(
                              padding: EdgeInsets.only(top: 12),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemCount: inDayMeasurement.length,
                          shrinkWrap: true,
                          itemBuilder: (_, i) {
                            final measurement = inDayMeasurement[i];
                            return _measurement(
                              measurement: measurement,
                            );
                          },
                          separatorBuilder: (_, __) {
                            return const Padding(
                              padding: EdgeInsets.only(top: 12),
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
            return const Padding(padding: EdgeInsets.only(top: 40));
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Row(
            children: [
              Image.memory(heart),
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  'EMMA Lite',
                  style: TextStyle(
                    fontFamily: AppTypography.textStyle,
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

  static Widget _measurement({Measurement measurement}) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 30,
              child: Text(
                DateFormat.Hm().format(measurement.dateTime),
                style: const TextStyle(
                  fontFamily: AppTypography.textStyle,
                  fontSize: 10,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                measurement.longTitle.tr,
                style: const TextStyle(
                  fontSize: 10,
                  fontFamily: AppTypography.textStyle,
                ),
              ),
            ),
            const Spacer(),
            Text(
              measurement.value(),
              style: const TextStyle(
                fontSize: 10,
                fontFamily: AppTypography.textStyle,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, left: 46),
          child: Row(
            children: [
              const Text(
                '',
                style: TextStyle(
                  fontFamily: AppTypography.textStyle,
                  fontSize: 8,
                  color: Color(0xff9B9B9B),
                ),
              ),
              const Spacer(),
              Text(
                measurement.units.tr,
                style: const TextStyle(
                  fontFamily: AppTypography.textStyle,
                  fontSize: 8,
                  color: Color(0xff9B9B9B),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _task({
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
            Image.memory(photo),
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 4,
              ),
              child: SizedBox(
                width: 50,
                child: Text(
                  DateFormat.Hm().format(task.dateTime),
                  style: const TextStyle(
                    fontFamily: AppTypography.textStyle,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 183,
              child: Text(
                '${task.assignName}${assign.countForPDFForTask(task)}',
                style: const TextStyle(
                  fontFamily: AppTypography.textStyle,
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
                        task.completed &&
                            task.completedDate.isAfter(task.dateTime)) {
                      return const SizedBox();
                    }
                    final now = DateTime.now();
                    final dif = now.difference(task.completedDate);
                    final minutes = dif.inMinutes - (dif.inHours * 60);
                    final hour = dif.inHours;
                    return Text(
                      '+$hourч ${minutes == 0 ? '' : '$minutes${'minText'.tr}'}',
                      style: const TextStyle(
                        fontFamily: AppTypography.textStyle,
                        fontSize: 8,
                        color: Color(0xff9B9B9B),
                      ),
                    );
                  },
                ),
              ),
              Text(
                '${assign.type.title}, ${assign.type is OtherAssignType ? 'самоназначение' : assign.doctorName}',
                style: const TextStyle(
                  fontFamily: AppTypography.textStyle,
                  fontSize: 8,
                  color: Color(0xff9B9B9B),
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
  }) {
    return Container(
      width: 530,
      height: 92,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Color(0xffCFD9DF)),
      ),
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 60,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Image.memory(noPhoto, width: 60, height: 60),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.firstName ?? ''} ${user.lastName ?? ''}',
                  style: const TextStyle(
                    fontFamily: AppTypography.textStyle,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    '${DateFormat('dd.MM.yyyy').format(user.date)}, ${DateTime.now().year - user.date.year} года',
                    style: const TextStyle(
                      fontFamily: AppTypography.textStyle,
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Image.memory(gender, width: 12, height: 12),
                    Padding(
                      padding: const EdgeInsets.only(left: 4, right: 24),
                      child: Text(
                        user.gender == null
                            ? ''
                            : user.gender == Gender.male
                            ? 'maleButtonTitle'.tr
                            : 'femaleButtonTitle'.tr,
                        style: const TextStyle(
                          fontSize: 8,
                          fontFamily: AppTypography.textStyle,
                        ),
                      ),
                    ),
                    Image.memory(weight, width: 12, height: 12),
                    Padding(
                      padding: const EdgeInsets.only(left: 4, right: 24),
                      child: Text(
                        '${user.weight} ${'weightUnit'.tr}',
                        style: const TextStyle(
                          fontSize: 8,
                          fontFamily: AppTypography.textStyle,
                        ),
                      ),
                    ),
                    Image.memory(height, width: 12, height: 12),
                    Padding(
                      padding: const EdgeInsets.only(left: 4, right: 24),
                      child: Text(
                        '${user.height} см',
                        style: const TextStyle(
                          fontSize: 8,
                          fontFamily: AppTypography.textStyle,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
            Text(
              user.phone ?? '',
              style: const TextStyle(
                fontFamily: AppTypography.textStyle,
                fontSize: 10,
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget _topDates({Uint8List calendar, Report report}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.memory(calendar),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('dd.MM.yyyy').format(report.startDate),
                style: const TextStyle(
                  fontFamily: AppTypography.textStyle,
                  fontSize: 10,
                ),
              ),
              Text(
                'startDateText'.tr,
                style: const TextStyle(
                  fontFamily: AppTypography.textStyle,
                  fontSize: 10,
                  color: Color(0xff9B9B9B),
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
                      color: Color(0xffCFD9DF),
                    ),
                    Container(
                      height: 1,
                      width: 346,
                      color: Color(0xffCFD9DF),
                    ),
                    Container(
                      height: 8,
                      width: 1,
                      color: Color(0xffCFD9DF),
                    ),
                  ],
                ),
              ),
              Text(
                '${report.difference} дней',
                style: const TextStyle(
                  fontFamily: AppTypography.textStyle,
                  fontSize: 10,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
        const Padding(padding: EdgeInsets.only(left: 16)),
        Image.memory(calendar),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('dd.MM.yyyy').format(report.endDate),
                style: const TextStyle(
                  fontFamily: AppTypography.textStyle,
                  fontSize: 10,
                ),
              ),
              const Text(
                'Дата конца',
                style: TextStyle(
                  fontFamily: AppTypography.textStyle,
                  fontSize: 10,
                  color: Color(0xff9B9B9B),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
