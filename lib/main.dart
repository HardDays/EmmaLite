import 'package:bot_toast/bot_toast.dart';
import 'package:emma_mobile/bloc/app_settings/app_settings_bloc.dart';
import 'package:emma_mobile/bloc/assign/assign_bloc.dart';
import 'package:emma_mobile/bloc/doctors_screen/doctors_bloc.dart';
import 'package:emma_mobile/bloc/measurement/measurement_cubit.dart';
import 'package:emma_mobile/bloc/profile/profile_cubit.dart';
import 'package:emma_mobile/bloc/sync/sync_cubit.dart';
import 'package:emma_mobile/models/app_settings/app_settings.dart';
import 'package:emma_mobile/models/doctor/doctor.dart';
import 'package:emma_mobile/models/measurements/arterial_pressure.dart';
import 'package:emma_mobile/models/measurements/blood_sugar.dart';
import 'package:emma_mobile/models/measurements/height_model.dart';
import 'package:emma_mobile/models/measurements/pulse.dart';
import 'package:emma_mobile/models/measurements/temperature.dart';
import 'package:emma_mobile/models/messages/messages.dart';
import 'package:emma_mobile/models/user/user.dart';
import 'package:emma_mobile/repositories/app_local_repository.dart';
import 'package:emma_mobile/repositories/measurement_local_repository.dart';
import 'package:emma_mobile/repositories/profile_local_repository.dart';
import 'package:emma_mobile/ui/routing/router.dart';
import 'package:emma_mobile/ui/screens/splash_screen.dart';
import 'package:emma_mobile/utils/hive_boxes.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  await HiveBoxes().init();
  await Static.init();

  final _localRepo = AppLocalRepository();
  final settings = _localRepo.getSettings();

  if (_localRepo.getSettings().currentProfileId == null) {
    final user = User();
    ProfileLocalRepository().addUser(user);
    _localRepo.putSettings(settings..currentProfileId = user.id);
  }

  Intl.defaultLocale = settings.locale ?? 'en';
  AppRouter.current.rootNavigatorKey = GlobalKey<NavigatorState>();
  final app = GetMaterialApp(
    title: 'Emma Mobile',
    navigatorKey: AppRouter.current.rootNavigatorKey,
    debugShowCheckedModeBanner: false,
    translations: Messages(),
    theme: ThemeData(
      brightness: settings.lightTheme ? Brightness.light : Brightness.dark,
      cupertinoOverrideTheme: CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
        dateTimePickerTextStyle: TextStyle(
          fontSize: 20,
        ),
      )),
      canvasColor: Colors.transparent,
      primaryColor: AppColors.c00ACE3,
    ),
    builder: BotToastInit(),
    navigatorObservers: [BotToastNavigatorObserver()],
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    locale: Locale(settings.locale ?? 'en'),
    supportedLocales: const [
      Locale('ru'),
      Locale('de'),
      Locale('en'),
      Locale('fr'),
      Locale('fr'),
      Locale('es'),
    ],
    fallbackLocale: const Locale('en'),
    themeMode: settings.lightTheme ? ThemeMode.light : ThemeMode.dark,
    home: SplashScreen(),
  );

  final providedApp = MultiBlocProvider(
    providers: [
      BlocProvider(
        lazy: false,
        create: (context) => MeasurementCubit(MeasurementLocalRepository()),
      ),
      BlocProvider(
        lazy: false,
        create: (context) => AssignBloc(),
      ),
      BlocProvider(
        lazy: false,
        create: (context) => DoctorsBloc(),
      ),
      BlocProvider(
        lazy: false,
        create: (_) => AppSettingsBloc(),
      ),
      BlocProvider(
        lazy: false,
        create: (_) => ProfileCubit(),
      ),
      BlocProvider(
        lazy: false,
        create: (_) => SyncCubit(),
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
  Hive.registerAdapter(DoctorAdapter());
  Hive.registerAdapter(AppSettingsAdapter());
  Hive.registerAdapter(UserAdapter());
}
