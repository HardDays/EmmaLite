abstract class Language {
  final String title;
  final String localizedTitle;
  final String locale;

  Language({
    this.title,
    this.locale,
    this.localizedTitle,
  });
}

final languages = [
  RuLanguage(),
  DeLanguage(),
  EnLanguage(),
  FrLanguage(),
  EsLanguage(),
];

class RuLanguage implements Language {
  @override
  String get locale => 'ru';

  @override
  String get localizedTitle => 'Русский';

  @override
  String get title => 'Русский';
}

class DeLanguage implements Language {
  @override
  String get locale => 'de';

  @override
  String get localizedTitle => 'Немецкий';

  @override
  String get title => 'Deutsche';
}

class EnLanguage implements Language {
  @override
  String get locale => 'en';

  @override
  String get localizedTitle => 'Английский';

  @override
  String get title => 'English';
}

class FrLanguage implements Language {
  @override
  String get locale => 'fr';

  @override
  String get localizedTitle => 'Французский';

  @override
  String get title => 'Français';
}

class EsLanguage implements Language {
  @override
  String get locale => 'es';

  @override
  String get localizedTitle => 'Испанский';

  @override
  String get title => 'Español';
}
