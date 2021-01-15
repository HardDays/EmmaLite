import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:emma_mobile/domain/common/async_field.dart';
import 'package:local_auth/local_auth.dart';

part 'app_common_state.g.dart';

abstract class AppCommonState
    implements Built<AppCommonState, AppCommonStateBuilder> {

  factory AppCommonState([void Function(AppCommonStateBuilder) updates]) =
      _$AppCommonState;

  AppCommonState._();

  static Serializer<AppCommonState> get serializer =>
      _$appCommonStateSerializer;

  @BuiltValueField(serialize: false)
  @nullable
  BiometricType get currentBiometricType;

  @nullable
  String get phone;

  @nullable
  String get token;

  @nullable
  bool get isLaunchFirstTime;

  @nullable
  String get pinCode;

  @nullable
  bool get biometryGranted;

  // @nullable
  // User get user;

  @BuiltValueField(serialize: false)
  @nullable
  AsyncField<String> get tempCode;

  @nullable
  bool get isRegistrationCompleted;

  @nullable
  bool get isAuthorized;
}
