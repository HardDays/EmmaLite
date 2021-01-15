import 'dart:ui';
import 'package:emma_mobile/di/injectable.config.dart';
import 'package:emma_mobile/di/service_locator.dart';
import 'package:emma_mobile/l10n/delegate.dart';
import 'package:injectable/injectable.dart';

@InjectableInit()
void configureDependencies() {
  appL10nDelegate.load(const Locale('ru'));
  $initGetIt(locator);

}
