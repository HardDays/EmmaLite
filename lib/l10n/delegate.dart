import 'package:date_format/date_format.dart' as df;
import 'package:emma_mobile/generated/l10n.dart';
import 'package:emma_mobile/l10n/dates.dart';
import 'package:flutter/material.dart';

const AppL10nDelegate appL10nDelegate = AppL10nDelegate();

S get l10n => AppL10nDelegate.current;

const _dateLocales = {
  'ru': RuDatesLocale(),
  'en': RuDatesLocale(),
};

class AppL10nDelegate extends AppLocalizationDelegate {
  const AppL10nDelegate();

  static S current;

  static df.Locale dateLocale = const df.EnglishLocale();

  @override
  Future<S> load(Locale locale) {
    updateTranslatableData(locale);
    return super.load(locale).then((s) {
      current = s;
      dateLocale =
          _dateLocales[locale.languageCode] ?? const df.EnglishLocale();
      return current;
    });
  }

  void updateTranslatableData(Locale locale) {
    //todo set translatable data from server
  }
}
