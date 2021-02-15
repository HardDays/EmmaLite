import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:emma_mobile/bloc/assign/assign_bloc.dart';
import 'package:emma_mobile/models/assignment/assign_type.dart';
import 'package:emma_mobile/models/assignment/tasks.dart';
import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/models/pdf_models.dart';
import 'package:emma_mobile/models/report/report.dart';
import 'package:emma_mobile/models/user/user.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
        size: Size(594, 125000),
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

  static Future<PageWidget> create({
    User user,
    Report report,
    List<RunTask> tasks,
    AssignBloc assignBloc,
    List<Measurement> measurementList,
    DayWidget previousPageLastDay,
    bool isFirst,
  }) async {
    const iconPath = 'assets/pdf_icons/';

    final done = await _loadImage('${iconPath}done.png');
    final donePart = await _loadImage('${iconPath}done_part.png');
    final notCompleted = await _loadImage('${iconPath}not_completed.png');
    final heart = await _loadImage('${iconPath}heart.png');

    double size = 0;

    List<Widget> widgets = [];

    List<DayWidget> dayWidgets = [];

    if (previousPageLastDay != null) {
      dayWidgets.add(previousPageLastDay);
    } else {
      dayWidgets.add(DayWidget(
        day: 0,
        endTask: 0,
        startTask: 0,
        endMeas: 0,
        startMeas: 0,
      ));
    }

    int index = dayWidgets.last.day + 0;

    Widget firstPageWidget;

    bool first = true;

    if (isFirst) {
      firstPageWidget = await _firstPageWidget(
        report: report,
        user: user,
        iconPath: iconPath,
      );
      size += (await getImage(widget: firstPageWidget)).height;
    }

    while (size < 950) {
      print('zzzzzzz');
      final currentDay = report.startDate.add(Duration(days: index));
      final inDayTasks =
          [...tasks].where((e) => e.dateTime.isInDay(currentDay)).toList();
      final inDayMeasurement = [...measurementList]
          .where((e) => e.dateTime.isInDay(currentDay))
          .toList();

      final widget = await _dayItem(
        assignBloc: assignBloc,
        notCompleted: notCompleted,
        donePart: donePart,
        done: done,
        currentDay: currentDay,
        inDayMeasurement: inDayMeasurement,
        inDayTasks: inDayTasks,
        initSize: size,
        initMeas: 0,
        initTask: dayWidgets.last.day == index ? dayWidgets.last.endTask : 0,
      );
      final widgetSize = (await getImage(widget: widget.widget)).height;
      size += widgetSize;
      if (size >= 950) {
        break;
      } else {
        DayWidget bufDay = DayWidget();
        bufDay.day = index;
        bufDay.startTask =
            dayWidgets.last.day == index ? dayWidgets.last.endTask : 0;
        bufDay.endTask = widget.taskIndex;
        bufDay.startMeas =
            dayWidgets.last.day == index ? dayWidgets.last.endMeas : 0;
        bufDay.endMeas = widget.measIndex;
        if (widget.taskIndex == inDayTasks.length &&
            widget.measIndex == inDayMeasurement.length) {
          index++;
        }
        if (index > report.difference) {
          break;
        } else {
          widgets.add(widget.widget);
          if (first) {
            dayWidgets.removeLast();
            first = false;
          }
          dayWidgets.add(bufDay);
        }
      }
    }
    List<DayWidget> d = [];
    for (var i = 0; i < dayWidgets.length; i++) {
      var index2 = report.startDate.add(Duration(days: dayWidgets.last.day));
      var t3 = [...tasks].where((e) => e.dateTime.isInDay(index2)).isNotEmpty;
      var m3 = [...measurementList]
          .where((e) => e.dateTime.isInDay(index2))
          .isNotEmpty;
      if ((dayWidgets[i].endTask == dayWidgets[i].startTask && dayWidgets[i].endMeas == dayWidgets[i].startMeas) &&
          (t3 || m3)) {
      } else {
        d.add(dayWidgets[i]);
      }
    }
    return PageWidget(
      dayWidgets: d,
      widget: SizedBox(
        height: 846,
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (firstPageWidget != null) firstPageWidget,
              ListView.builder(
                itemCount: widgets.length,
                shrinkWrap: true,
                itemBuilder: (_, i) {
                  return widgets[i];
                },
              ),
              const Spacer(),
              _bottom(heart: heart),
            ],
          ),
        ),
      ),
    );
  }

  static Future<WidgetReturn> _dayItem({
    DateTime currentDay,
    List<RunTask> inDayTasks,
    Uint8List notCompleted,
    Uint8List donePart,
    Uint8List done,
    AssignBloc assignBloc,
    List<Measurement> inDayMeasurement,
    double initSize,
    int initMeas,
    int initTask,
  }) async {
    WidgetReturn widgetReturn = WidgetReturn();
    double size = 0;

    final Widget topWidget = Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        DateFormat('dd.MM.yyyy').format(currentDay),
        style: const TextStyle(
          fontFamily: AppTypography.textStyle,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
    final title = _taskTitle(inDayTasks: inDayTasks);
    size += (await getImage(widget: topWidget)).height;
    size += (await getImage(widget: title)).height;

    double measSize = 0;
    int taskIndex = initTask;
    int measIndex = initMeas;

    final List<Widget> taskWidgets = [];
    final List<Widget> measWidgets = [];

    for (var i = initTask; i < inDayTasks.length; i++) {
      final taskWidget = _task(
        done: done,
        donePart: donePart,
        notCompleted: notCompleted,
        task: inDayTasks[i],
        assignBloc: assignBloc,
        haveTopPadding: taskIndex != 0,
      );
      size += (await getImage(widget: taskWidget)).height;
      if (size + initSize > 900) {
        break;
      } else {
        taskWidgets.add(taskWidget);
        taskIndex++;
      }
    }

    for (var i = initMeas; i < inDayMeasurement.length; i++) {
      final taskWidget = _measurement(
        haveTopPadding: measIndex != 0,
        measurement: inDayMeasurement[i],
      );
      measSize += (await getImage(widget: taskWidget)).height;
      if (measSize + initSize > 900) {
        break;
      } else {
        measWidgets.add(taskWidget);
        measIndex++;
      }
    }

    widgetReturn.widget = SizedBox(
      width: 530,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          topWidget,
          title,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: taskWidgets.length,
                  shrinkWrap: true,
                  itemBuilder: (_, i) {
                    return taskWidgets[i];
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: measWidgets.length,
                  shrinkWrap: true,
                  itemBuilder: (_, i) {
                    return measWidgets[i];
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
    widgetReturn.taskIndex = taskIndex;
    widgetReturn.measIndex = measIndex;

    return widgetReturn;
  }

  static Widget _taskTitle({List<RunTask> inDayTasks}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
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
    );
  }

  static Widget _bottom({Uint8List heart}) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
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
    );
  }

  static Widget _measurement({Measurement measurement, bool haveTopPadding}) {
    return Padding(
      padding: EdgeInsets.only(top: haveTopPadding ? 12 : 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
      ),
    );
  }

  static Widget _task({
    RunTask task,
    Uint8List notCompleted,
    Uint8List donePart,
    Uint8List done,
    AssignBloc assignBloc,
    bool haveTopPadding,
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
    return Padding(
      padding: EdgeInsets.only(top: haveTopPadding ? 12 : 0),
      child: SizedBox(
        width: 594 / 2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                    maxLines: null,
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
        ),
      ),
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
                        '${user.weight ?? ''} ${'weightUnit'.tr}',
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
                        '${user.height ?? ''} см',
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

  static Future<Widget> _firstPageWidget({
    Report report,
    User user,
    String iconPath,
  }) async {
    final calendar = await _loadImage('${iconPath}calendar.png');
    final gender = await _loadImage('${iconPath}gender_male.png');

    final genderPath = user.gender == Gender.female
        ? '${iconPath}no_photo_woman.png'
        : '${iconPath}no_photo_man.png';
    final noPhoto = user.photo.isEmpty
        ? await _loadImage(genderPath)
        : File(user.photo).readAsBytesSync();
    final height = await _loadImage('${iconPath}height.png');
    final weight = await _loadImage('${iconPath}weight.png');
    return Column(
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
      ],
    );
  }
}
