import 'package:flutter/material.dart';

class AppImages {
  const AppImages._();

  static Widget emptyAvatar() {
    return Image.asset(
      'assets/images/empty_avatar.png',
      fit: BoxFit.contain,
    );
  }

  static Widget delete() {
    return Image.asset(
      'assets/images/delete.png',
      fit: BoxFit.contain,
    );
  }

  static Widget faceId() {
    return Image.asset(
      'assets/images/face_id.png',
      fit: BoxFit.contain,
    );
  }

  static Widget intro() {
    return Image.asset(
      'assets/images/intro.png',
      fit: BoxFit.contain,
    );
  }

  static Widget introSecure() {
    return Image.asset(
      'assets/images/intro_secure.png',
      fit: BoxFit.contain,
    );
  }

  static Widget logoSymbol() {
    return Image.asset(
      'assets/images/logo_symbol.png',
      fit: BoxFit.contain,
    );
  }

  static Widget profileImageDefault() {
    return Image.asset(
      'assets/images/profile_image_default.png',
      fit: BoxFit.contain,
    );
  }

  static Widget touchId() {
    return Image.asset(
      'assets/images/touch_id.png',
      fit: BoxFit.contain,
    );
  }
}
