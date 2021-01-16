import 'package:emma_mobile/app_common/app_common.dart';
import 'package:emma_mobile/bloc/assignment/assignment_cubit.dart';
import 'package:emma_mobile/bloc/main/main_cubit.dart';
import 'package:emma_mobile/bloc/measurement/measurement_cubit.dart';
import 'package:emma_mobile/data/repositories/app_local_repository.dart';
import 'package:emma_mobile/data/repositories/assignment_local_repository.dart';
import 'package:emma_mobile/data/repositories/main_local_repository.dart';
import 'package:emma_mobile/data/repositories/measurement_local_repository.dart';
import 'package:emma_mobile/di/injectable.dart';
import 'package:emma_mobile/di/service_locator.dart';
import 'package:emma_mobile/l10n/delegate.dart';
import 'package:emma_mobile/models/measurements/measurement.dart';
import 'package:emma_mobile/ui/routing/router.dart';
import 'package:emma_mobile/ui/screens/navigator_screen.dart';
import 'package:emma_mobile/ui/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await initHive();
  AppRouter.current.rootNavigatorKey = GlobalKey<NavigatorState>();
  final app = MaterialApp(
    title: 'Emma Mobile',
    navigatorKey: AppRouter.current.rootNavigatorKey,
    debugShowCheckedModeBanner: false,
    theme: mainThemeData,
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
        create: (context) => AppCommon(locator.get<AppLocalRepository>()),
      ),
      BlocProvider(
        lazy: true,
        create: (context) => MainCubit(locator.get<MainLocalRepository>()),
      ),
      BlocProvider(
        lazy: true,
        create: (context) =>
            AssignmentCubit(locator.get<AssignmentLocalRepository>()),
      ),
      BlocProvider(
        lazy: true,
        create: (context) =>
            MeasurementCubit(locator.get<MeasurementLocalRepository>()),
      ),
    ],
    child: app,
  );
  runApp(providedApp);
}

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MeasurementAdapter());
}
