import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcons {
  const AppIcons._();

  static Widget accept() {
    return SvgPicture.asset(
      'assets/icons/accept.svg',
      fit: BoxFit.fill,
    );
  }

  static Widget arrowRight() {
    return SvgPicture.asset(
      'assets/icons/arrow_right.svg',
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

  static Widget run() {
    return SvgPicture.asset(
      'assets/icons/run.svg',
      fit: BoxFit.fill,
    );
  }

  static Widget trash() {
    return SvgPicture.asset(
      'assets/icons/trash.svg',
      fit: BoxFit.fill,
    );
  }

  static Widget calendar() {
    return SvgPicture.asset(
      'assets/icons/calendar.svg',
    );
  }

  static Widget calendarActive() {
    return SvgPicture.asset(
      'assets/icons/calendar_active.svg',
    );
  }

  static Widget plus() {
    return SvgPicture.asset(
      'assets/icons/plus.svg',
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

  static Widget doctors() {
    return SvgPicture.asset(
      'assets/icons/doctors.svg',
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

  static Widget menuAdd() {
    return SvgPicture.asset(
      'assets/icons/menu_add.svg',
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

  static Widget prescriptionsInactive({double width, double height}) {
    return SvgPicture.asset(
      'assets/icons/prescriptions_inactive.svg',
      width: width,
      height: height,
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
