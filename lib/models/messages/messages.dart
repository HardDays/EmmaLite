import 'package:emma_mobile/models/messages/de.dart';
import 'package:emma_mobile/models/messages/en.dart';
import 'package:emma_mobile/models/messages/es.dart';
import 'package:emma_mobile/models/messages/fr.dart';
import 'package:emma_mobile/models/messages/ru.dart';
import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ru': RuMessages.messages,
        'en': EnMessages.messages,
        'de': DeMessages.messages,
        'fr': FrMessages.messages,
        'es': EsMessages.messages,
      };
}
