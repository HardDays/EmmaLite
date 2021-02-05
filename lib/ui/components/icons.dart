import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcons {
  const AppIcons._();

  static Widget accept({double width, double height, Color color}) {
    return SvgPicture.asset(
      'assets/icons/accept.svg',
      width: width,
      height: height,
      color: color,
      fit: BoxFit.fill,
    );
  }

  static Widget arrowRight() {
    return SvgPicture.asset(
      'assets/icons/arrow_right.svg',
      fit: BoxFit.fill,
    );
  }

  static Widget paperClip() {
    return SvgPicture.asset(
      'assets/icons/paper_clip.svg',
      fit: BoxFit.fill,
    );
  }

  static Widget divan({Color color}) {
    return SvgPicture.asset(
      'assets/icons/divan.svg',
      fit: BoxFit.fill,
      color: color,
    );
  }

  static Widget run({Color color}) {
    return SvgPicture.asset(
      'assets/icons/run.svg',
      fit: BoxFit.fill,
      color: color,
    );
  }

  static Widget trash({Color color}) {
    return SvgPicture.asset(
      'assets/icons/trash.svg',
      color: color,
      width: 24.w,
      height: 24.w,
      fit: BoxFit.fill,
    );
  }

  static Widget calendar() {
    return SvgPicture.asset(
      'assets/icons/calendar.svg',
    );
  }

  static Widget minus() {
    return SvgPicture.asset(
      'assets/icons/minus.svg',
    );
  }

  static Widget calendarActive() {
    return SvgPicture.asset(
      'assets/icons/calendar_active.svg',
    );
  }

  static Widget plus({Color color, double size}) {
    return SvgPicture.asset(
      'assets/icons/plus.svg',
      color: color,
      width: size,
      height: size,
      fit: BoxFit.fill,
    );
  }

  static Widget chevronLeft() {
    return SvgPicture.asset(
      'assets/icons/chevron_left.svg',
      fit: BoxFit.fill,
    );
  }

  static Widget close() {
    return SvgPicture.asset(
      'assets/icons/close.svg',
      fit: BoxFit.fill,
    );
  }

  static Widget doctors({double size}) {
    return SvgPicture.asset(
      'assets/icons/doctors.svg',
      width: size,
      height: size,
      fit: BoxFit.fill,
    );
  }

  static Widget graphActive() {
    return SvgPicture.asset(
      'assets/icons/graph_active.svg',
      fit: BoxFit.fill,
    );
  }

  static Widget graphInactive() {
    return SvgPicture.asset(
      'assets/icons/graph_inactive.svg',
      fit: BoxFit.fill,
    );
  }

  static Widget measurementDefault({double width, double height}) {
    return SvgPicture.asset(
      'assets/icons/measurement_default.svg',
      height: height,
      width: width,
      fit: BoxFit.fill,
    );
  }

  static Widget measurementsActive() {
    return SvgPicture.asset(
      'assets/icons/measurements_active.svg',
      fit: BoxFit.fill,
    );
  }

  static Widget measurementsInactive({double width, double height}) {
    return SvgPicture.asset(
      'assets/icons/measurements_inactive.svg',
      width: width,
      height: height,
      fit: BoxFit.fill,
    );
  }

  static Widget menuActive() {
    return SvgPicture.asset(
      'assets/icons/menu_active.svg',
      fit: BoxFit.fill,
    );
  }

  static Widget menuInactive() {
    return SvgPicture.asset(
      'assets/icons/menu_inactive.svg',
      fit: BoxFit.fill,
    );
  }

  static Widget prescriptionsActive() {
    return SvgPicture.asset(
      'assets/icons/prescriptions_active.svg',
      fit: BoxFit.fill,
    );
  }

  static Widget complete({double size}) {
    return SvgPicture.asset(
      'assets/icons/complete.svg',
      width: size ?? 32.w,
      height: size ?? 32.w,
      fit: BoxFit.fill,
    );
  }

  static Widget prescriptionsInactive({
    double width,
    double height,
    Color color,
  }) {
    return SvgPicture.asset(
      'assets/icons/prescriptions_inactive.svg',
      width: width,
      height: height,
      color: color,
      fit: BoxFit.fill,
    );
  }

  static Widget profile() {
    return SvgPicture.asset(
      'assets/icons/profile.svg',
      fit: BoxFit.fill,
    );
  }

  static Widget report() {
    return SvgPicture.asset(
      'assets/icons/report.svg',
      fit: BoxFit.fill,
    );
  }

  static Widget settings() {
    return SvgPicture.asset(
      'assets/icons/settings.svg',
      fit: BoxFit.fill,
    );
  }
}
