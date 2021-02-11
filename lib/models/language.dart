abstract class Language {
  final String title;
  final String localizedTitle;
  final String locale;
  final String iconPath;

  Language({
    this.title,
    this.locale,
    this.localizedTitle,
    this.iconPath,
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

  @override
  String get iconPath => 'assets/icons/russia.svg';
}

class DeLanguage implements Language {
  @override
  String get locale => 'de';

  @override
  String get localizedTitle => 'Немецкий';

  @override
  String get title => 'Deutsche';

  @override
  String get iconPath => 'assets/icons/germany.svg';
}

class EnLanguage implements Language {
  @override
  String get locale => 'en';

  @override
  String get localizedTitle => 'Английский';

  @override
  String get title => 'English';

  @override
  String get iconPath => 'assets/icons/united_kingdom.svg';
}

class FrLanguage implements Language {
  @override
  String get locale => 'fr';

  @override
  String get localizedTitle => 'Французский';

  @override
  String get title => 'Français';

  @override
  String get iconPath => 'assets/icons/france.svg';
}

class EsLanguage implements Language {
  @override
  String get locale => 'es';

  @override
  String get localizedTitle => 'Испанский';

  @override
  String get title => 'Español';

  @override
  String get iconPath => 'assets/icons/spain.svg';
}
