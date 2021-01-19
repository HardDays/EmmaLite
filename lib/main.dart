import 'package:bot_toast/bot_toast.dart';
import 'package:emma_mobile/app_common/app_common.dart';
import 'package:emma_mobile/bloc/measurement/measurement_cubit.dart';
import 'package:emma_mobile/l10n/delegate.dart';
import 'package:emma_mobile/models/measurements/arterial_pressure.dart';
import 'package:emma_mobile/models/measurements/blood_sugar.dart';
import 'package:emma_mobile/models/measurements/height_model.dart';
import 'package:emma_mobile/models/measurements/pulse.dart';
import 'package:emma_mobile/models/measurements/temperature.dart';
import 'package:emma_mobile/repositories/app_local_repository.dart';
import 'package:emma_mobile/repositories/measurement_local_repository.dart';
import 'package:emma_mobile/ui/routing/router.dart';
import 'package:emma_mobile/ui/screens/navigator_screen.dart';
import 'package:emma_mobile/ui/styles/themes.dart';
import 'package:emma_mobile/utils/hive_boxes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  await HiveBoxes().init();
  AppRouter.current.rootNavigatorKey = GlobalKey<NavigatorState>();
  final app = MaterialApp(
    title: 'Emma Mobile',
    navigatorKey: AppRouter.current.rootNavigatorKey,
    debugShowCheckedModeBanner: false,
    theme: mainThemeData,
    builder: BotToastInit(), //1. call BotToastInit
    navigatorObservers: [BotToastNavigatorObserver()],
    localizationsDelegates: const [
      appL10nDelegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: appL10nDelegate.supportedLocales,
    themeMode: ThemeMode.light,
    // routes: AppRoutes.appRouteBuilder,
    home: NavigatorScreen(),
  );

  final providedApp = MultiBlocProvider(
    providers: [
      BlocProvider(
        lazy: false,
        create: (context) => AppCommon(AppLocalRepository()),
      ),
      BlocProvider(
        lazy: false,
        create: (context) =>
            MeasurementCubit(MeasurementLocalRepository()),
      ),
    ],
    child: app,
  );
  runApp(providedApp);
}

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ArterialPressureAdapter());
  Hive.registerAdapter(BloodSugarAdapter());
  Hive.registerAdapter(HeightModelAdapter());
  Hive.registerAdapter(PulseAdapter());
  Hive.registerAdapter(TemperatureAdapter());
}
