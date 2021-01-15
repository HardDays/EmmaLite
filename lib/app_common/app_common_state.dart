abstract class AppCommonState {}

class LoadingAppCommonState extends AppCommonState {}

class DataAppCommonState extends AppCommonState {}

// abstract class _AppCommonState
//     implements Built<_AppCommonState, AppCommonStateBuilder> {
//
//   factory AppCommonState([void Function(AppCommonStateBuilder) updates]) =
//       _$AppCommonState;
//
//   AppCommonState._();
//
//   static Serializer<AppCommonState> get serializer =>
//       _$appCommonStateSerializer;
//
//   @BuiltValueField(serialize: false)
//   @nullable
//   BiometricType get currentBiometricType;
//
//   @nullable
//   String get phone;
//
//   @nullable
//   String get token;
//
//   @nullable
//   bool get isLaunchFirstTime;
//
//   @nullable
//   String get pinCode;
//
//   @nullable
//   bool get biometryGranted;
//
//   // @nullable
//   // User get user;
//
//   @BuiltValueField(serialize: false)
//   @nullable
//   AsyncField<String> get tempCode;
//
//   @nullable
//   bool get isRegistrationCompleted;
//
//   @nullable
//   bool get isAuthorized;
// }
