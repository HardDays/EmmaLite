// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../data/repositories/app_local_repository.dart';
import '../domain/repositories/app_repository.dart';
import '../data/repositories/assignment_local_repository.dart';
import '../domain/repositories/assignment_repository.dart';
import '../data/repositories/main_local_repository.dart';
import '../domain/repositories/main_repository.dart';
import '../data/repositories/measurement_local_repository.dart';
import '../domain/repositories/measurement_repository.dart';
import '../data/repositories/profile_local_repository.dart';
import '../domain/repositories/profile_repository.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.factory<AppRepository>(() => AppLocalRepository());
  gh.factory<AssignmentRepository>(() => AssignmentLocalRepository());
  gh.factory<MainRepository>(() => MainLocalRepository());
  gh.factory<MeasurementRepository>(() => MeasurementLocalRepository());
  gh.factory<ProfileRepository>(() => ProfileLocalRepository());
  return get;
}
