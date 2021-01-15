import 'package:date_format/date_format.dart';

String formatDateToString(DateTime date) {

  final format = [dd, ' ', M, ' ', yyyy];
  return _replace(formatDate(date, format));
  
}

String dateTimeToString(DateTime date) {
  final format = [dd, ' ', M, ' ', yyyy,', ', HH, ':', nn];
  return _replace(formatDate(date, format));
}

final dateMap = {
  'Jan':'Янв',
  'Feb':'Фев',
  'Mar':'Мар',
  'Apr':'Апр',
  'May':'Мая',
  'Jun':'Июн',
  'Jul':'Июл',
  'Aug':'Авг',
  'Sep':'Сен',
  'Oct':'Окт',
  'Nov':'Ноя',
  'Dec':'Дек',
};

String _replace(String original) {
  var replace = original;

  for (var i in dateMap.keys) {
    if(replace.contains(i)) {
      replace = replace.replaceAll(i, dateMap[i]);
    }
  }
  return replace;
}

String greetingStringBasedOn(DateTime dayTime) {
  final hour = dayTime.hour;
  if(hour >= 0 && hour < 6) {
    return 'Доброй ночи';
  } else if(hour >= 6 && hour < 12) {
    return 'Доброе утро';
  } else if(hour >= 12 && hour < 18) {
    return 'Добрый день';
  } else {
    return 'Добрый вечер';
  }
}