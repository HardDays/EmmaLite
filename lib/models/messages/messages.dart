import 'package:get/get.dart';
import 'package:emma_mobile/models/messages/ru.dart';
import 'package:emma_mobile/models/messages/en.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'ru': RuMessages.messages,
    'en': EnMessages.messages,

  };
}