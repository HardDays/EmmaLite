import 'package:date_format/date_format.dart';

class RuDatesLocale implements Locale {
  const RuDatesLocale();

  @override
  // ignore: avoid_field_initializers_in_const_classes
  final List<String> monthsShort = const [
    'Янв',
    'Фeв',
    'Мар',
    'Апр',
    'Май',
    'Июн',
    'Иол',
    'Авг',
    'Сен',
    'Окт',
    'Ноя',
    'Дек'
  ];

  @override
  // ignore: avoid_field_initializers_in_const_classes
  final List<String> monthsLong = const [
    'Января',
    'Февраля',
    'Марта',
    'Апреля',
    'Мая',
    'Июня',
    'Июля',
    'Августа',
    'Сентября',
    'Октября',
    'Ноября',
    'Декабря'
  ];

  @override
  // ignore: avoid_field_initializers_in_const_classes
  final List<String> daysShort = const [
    'Пн',
    'Вт',
    'Ср',
    'Чт',
    'Пт',
    'Сб',
    'Вс'
  ];

  @override
  // ignore: avoid_field_initializers_in_const_classes
  final List<String> daysLong = const [
    'Понедельник',
    'Вторник',
    'Среда',
    'Четверг',
    'Пятница',
    'Суббота',
    'Воскресение'
  ];

  @override
  String get am => 'AM';

  @override
  String get pm => 'PM';
}
