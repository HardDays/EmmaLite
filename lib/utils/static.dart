import 'dart:io';

import 'package:dio/dio.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/services.dart';
import 'package:image/image.dart';

class Static {
  static Static _instance;

  factory Static() {
    _instance ??= Static._internal();
    return _instance;
  }

  Static._internal();

  static Future<void> init() async {
    _instance ??= Static._internal();
  }

  static void lightStatusBarTheme() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ));
  }

  static void darkStatusBarTheme() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  static Dio dio() {
    final baseClient = Dio(
      BaseOptions(baseUrl: ApiPath.baseUrl),
    );
    baseClient.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true),
    );
    return baseClient;
  }

  static MultipartFile resizeImage({@required String path}) {
    final image = decodeImage(File(path).readAsBytesSync());

    Image resizeImage;
    if (image.height > image.width) {
      resizeImage = copyResize(image, height: 640);
    } else {
      resizeImage = copyResize(image, width: 640);
    }
    return MultipartFile.fromBytes(
      encodePng(resizeImage),
      filename: '$path.jpg',
    );
  }
}
