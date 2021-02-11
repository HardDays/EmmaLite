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

  static Widget memory() {
    return SvgPicture.asset(
      'assets/icons/memory.svg',
      width: 20.w,
      height: 20.w,
      fit: BoxFit.fill,
    );
  }

  static Widget design() {
    return SvgPicture.asset(
      'assets/icons/design.svg',
      width: 20.w,
      height: 20.w,
      fit: BoxFit.fill,
    );
  }

  static Widget language() {
    return SvgPicture.asset(
      'assets/icons/language.svg',
      width: 20.w,
      height: 20.w,
      fit: BoxFit.fill,
    );
  }

  static Widget languageFlag({String path}) {
    return SvgPicture.asset(
      path,
      width: 32,
      height: 32,
      fit: BoxFit.fill,
    );
  }

  static Widget health() {
    return SvgPicture.asset(
      'assets/icons/health.svg',
      width: 20.w,
      height: 20.w,
      fit: BoxFit.fill,
    );
  }

  static Widget privacyDocs() {
    return SvgPicture.asset(
      'assets/icons/privacy_docs.svg',
      width: 20.w,
      height: 20.w,
      fit: BoxFit.fill,
    );
  }

  static Widget message() {
    return SvgPicture.asset(
      'assets/icons/message.svg',
      width: 20.w,
      height: 20.w,
      fit: BoxFit.fill,
    );
  }

  static Widget documents() {
    return SvgPicture.asset(
      'assets/icons/documents.svg',
      width: 20.w,
      height: 20.w,
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
      color: color,
      fit: BoxFit.fill,
    );
  }

  static Widget delete({Color color}) {
    return SvgPicture.asset(
      'assets/icons/delete.svg',
      width: 42.w,
      height: 27.h,
      color: color,
      fit: BoxFit.fill,
    );
  }

  static Widget faceId({double size}) {
    return SvgPicture.asset(
      'assets/icons/face_id.svg',
      width: size ?? 40.w,
      height: size ?? 40.h,
      fit: BoxFit.fill,
    );
  }

  static Widget touchId({double size}) {
    return Image.asset(
      'assets/icons/touch_id.png',
      width: size ?? 40.w,
      height: size ?? 40.h,
      fit: BoxFit.fill,
    );
  }

  static Widget trash({Color color, double size}) {
    return SvgPicture.asset(
      'assets/icons/trash.svg',
      color: color,
      width: size ?? 24.w,
      height: size ?? 24.w,
      fit: BoxFit.fill,
    );
  }

  static Widget calendar() {
    return SvgPicture.asset(
      'assets/icons/calendar_active.svg',
      color: const Color(0xff78739A),
    );
  }

  static Widget privacy() {
    return SvgPicture.asset(
      'assets/icons/privacy.svg',
      width: 20.w,
      height: 20.w,
      fit: BoxFit.fill,
    );
  }

  static Widget minus() {
    return Container(
      width: 16,
      height: 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.c00ACE3,
      ),
      clipBehavior: Clip.antiAlias,
    );
  }

  static Widget calendarActive() {
    return SvgPicture.asset(
      'assets/icons/calendar_active.svg',
    );
  }

  static Widget check({double size}) {
    return SvgPicture.asset(
      'assets/icons/check.svg',
      width: size,
      height: size,
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

  static Widget profile({double size}) {
    return SvgPicture.asset(
      'assets/icons/profile.svg',
      width: size,
      height: size,
      fit: BoxFit.fill,
    );
  }

  static Widget report() {
    return SvgPicture.asset(
      'assets/icons/report.svg',
      fit: BoxFit.fill,
    );
  }

  static Widget info() {
    return SvgPicture.asset(
      'assets/icons/info.svg',
      width: 16.w,
      height: 16.w,
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
