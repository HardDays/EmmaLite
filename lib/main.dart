import 'package:emma_mobile/app_common/app_common.dart';
import 'package:emma_mobile/bloc/assignment/assignment_cubit.dart';
import 'package:emma_mobile/bloc/main/main_cubit.dart';
import 'package:emma_mobile/bloc/measurement/measurement_cubit.dart';
import 'package:emma_mobile/di/injectable.dart';
import 'package:emma_mobile/di/service_locator.dart';
import 'package:emma_mobile/domain/model/measurements/measurement.dart';
import 'package:emma_mobile/domain/repositories/app_repository.dart';
import 'package:emma_mobile/domain/repositories/assignment_repository.dart';
import 'package:emma_mobile/domain/repositories/main_repository.dart';
import 'package:emma_mobile/domain/repositories/measurement_repository.dart';
import 'package:emma_mobile/l10n/delegate.dart';
import 'package:emma_mobile/ui/routing/router.dart';
import 'package:emma_mobile/ui/screens/home/root_screen.dart';
import 'package:emma_mobile/ui/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await initHive();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
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
    home: RootScreen(),
  );

  final providedApp = MultiBlocProvider(
    providers: [
      BlocProvider(
        lazy: false,
        create: (context) => AppCommon(locator.get<AppRepository>())..init(),
      ),
      BlocProvider(
        lazy: true,
        create: (context) => MainCubit(locator.get<MainRepository>())..init(),
      ),
      BlocProvider(
        lazy: true,
        create: (context) =>
            AssignmentCubit(locator.get<AssignmentRepository>())..init(),
      ),
      BlocProvider(
        lazy: true,
        create: (context) =>
            MeasurementCubit(locator.get<MeasurementRepository>())..init(),
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
