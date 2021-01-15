import 'package:dio/dio.dart';
import 'package:emma_mobile/domain/model/common/error_model.dart';

ErrorModel mapToErrorModel(error) {
  if (error is ErrorModel) {
    return error;
  }

  if (error is DioError) {
    if (error.response?.data is Map &&
        error.response?.data['errors'] != null &&
        error.response.data['errors'] is Iterable) {
      final message =
          error.response?.data['errors'].first ?? 'Что-то пошло не так...';
      return ErrorModel((e) {
        e.message = message;
        e.code = '${error.response?.statusCode}';
        e.details = '${error.response?.statusMessage}';
      });
    }

    if (error.response?.data is Map &&
        error.response?.data['message'] != null) {
      return ErrorModel((e) {
        e.message = error.response.data['message'];
        e.code = error.response.data['code'];
        e.details = '${error.response?.statusMessage}';
      });
    }

    return ErrorModel((e) {
      e.message = 'Что-то пошло не так...';
      e.code = '${error.response?.statusCode}';
      e.details = '${error.response?.statusMessage}';
    });
  }

  return ErrorModel((e) {
    e.message = 'Что-то пошло не так...';
    e.details = '$error';
  });
}
