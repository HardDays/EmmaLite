import 'package:get/get.dart';

final dateMap = {
  'Jan': 'Янв',
  'Feb': 'Фев',
  'Mar': 'Мар',
  'Apr': 'Апр',
  'May': 'Мая',
  'Jun': 'Июн',
  'Jul': 'Июл',
  'Aug': 'Авг',
  'Sep': 'Сен',
  'Oct': 'Окт',
  'Nov': 'Ноя',
  'Dec': 'Дек',
};

String greetingStringBasedOn(DateTime dayTime) {
  final hour = dayTime.hour;
  if (hour >= 0 && hour < 6) {
    return 'titleNightLabel'.tr;
  } else if (hour >= 6 && hour < 12) {
    return 'titleMorningLabel'.tr;
  } else if (hour >= 12 && hour < 18) {
    return 'titleSunLabel'.tr;
  } else {
    return 'titleEvenLabel'.tr;
  }
}
