// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_common_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AppCommonState> _$appCommonStateSerializer =
    new _$AppCommonStateSerializer();

class _$AppCommonStateSerializer
    implements StructuredSerializer<AppCommonState> {
  @override
  final Iterable<Type> types = const [AppCommonState, _$AppCommonState];
  @override
  final String wireName = 'AppCommonState';

  @override
  Iterable<Object> serialize(Serializers serializers, AppCommonState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.phone != null) {
      result
        ..add('phone')
        ..add(serializers.serialize(object.phone,
            specifiedType: const FullType(String)));
    }
    if (object.token != null) {
      result
        ..add('token')
        ..add(serializers.serialize(object.token,
            specifiedType: const FullType(String)));
    }
    if (object.isLaunchFirstTime != null) {
      result
        ..add('isLaunchFirstTime')
        ..add(serializers.serialize(object.isLaunchFirstTime,
            specifiedType: const FullType(bool)));
    }
    if (object.pinCode != null) {
      result
        ..add('pinCode')
        ..add(serializers.serialize(object.pinCode,
            specifiedType: const FullType(String)));
    }
    if (object.biometryGranted != null) {
      result
        ..add('biometryGranted')
        ..add(serializers.serialize(object.biometryGranted,
            specifiedType: const FullType(bool)));
    }
    if (object.isRegistrationCompleted != null) {
      result
        ..add('isRegistrationCompleted')
        ..add(serializers.serialize(object.isRegistrationCompleted,
            specifiedType: const FullType(bool)));
    }
    if (object.isAuthorized != null) {
      result
        ..add('isAuthorized')
        ..add(serializers.serialize(object.isAuthorized,
            specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  AppCommonState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AppCommonStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'phone':
          result.phone = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'token':
          result.token = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'isLaunchFirstTime':
          result.isLaunchFirstTime = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'pinCode':
          result.pinCode = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'biometryGranted':
          result.biometryGranted = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'isRegistrationCompleted':
          result.isRegistrationCompleted = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'isAuthorized':
          result.isAuthorized = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$AppCommonState extends AppCommonState {
  @override
  final BiometricType currentBiometricType;
  @override
  final String phone;
  @override
  final String token;
  @override
  final bool isLaunchFirstTime;
  @override
  final String pinCode;
  @override
  final bool biometryGranted;
  @override
  final AsyncField<String> tempCode;
  @override
  final bool isRegistrationCompleted;
  @override
  final bool isAuthorized;

  factory _$AppCommonState([void Function(AppCommonStateBuilder) updates]) =>
      (new AppCommonStateBuilder()..update(updates)).build();

  _$AppCommonState._(
      {this.currentBiometricType,
      this.phone,
      this.token,
      this.isLaunchFirstTime,
      this.pinCode,
      this.biometryGranted,
      this.tempCode,
      this.isRegistrationCompleted,
      this.isAuthorized})
      : super._();

  @override
  AppCommonState rebuild(void Function(AppCommonStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppCommonStateBuilder toBuilder() =>
      new AppCommonStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppCommonState &&
        currentBiometricType == other.currentBiometricType &&
        phone == other.phone &&
        token == other.token &&
        isLaunchFirstTime == other.isLaunchFirstTime &&
        pinCode == other.pinCode &&
        biometryGranted == other.biometryGranted &&
        tempCode == other.tempCode &&
        isRegistrationCompleted == other.isRegistrationCompleted &&
        isAuthorized == other.isAuthorized;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc($jc(0, currentBiometricType.hashCode),
                                    phone.hashCode),
                                token.hashCode),
                            isLaunchFirstTime.hashCode),
                        pinCode.hashCode),
                    biometryGranted.hashCode),
                tempCode.hashCode),
            isRegistrationCompleted.hashCode),
        isAuthorized.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppCommonState')
          ..add('currentBiometricType', currentBiometricType)
          ..add('phone', phone)
          ..add('token', token)
          ..add('isLaunchFirstTime', isLaunchFirstTime)
          ..add('pinCode', pinCode)
          ..add('biometryGranted', biometryGranted)
          ..add('tempCode', tempCode)
          ..add('isRegistrationCompleted', isRegistrationCompleted)
          ..add('isAuthorized', isAuthorized))
        .toString();
  }
}

class AppCommonStateBuilder
    implements Builder<AppCommonState, AppCommonStateBuilder> {
  _$AppCommonState _$v;

  BiometricType _currentBiometricType;
  BiometricType get currentBiometricType => _$this._currentBiometricType;
  set currentBiometricType(BiometricType currentBiometricType) =>
      _$this._currentBiometricType = currentBiometricType;

  String _phone;
  String get phone => _$this._phone;
  set phone(String phone) => _$this._phone = phone;

  String _token;
  String get token => _$this._token;
  set token(String token) => _$this._token = token;

  bool _isLaunchFirstTime;
  bool get isLaunchFirstTime => _$this._isLaunchFirstTime;
  set isLaunchFirstTime(bool isLaunchFirstTime) =>
      _$this._isLaunchFirstTime = isLaunchFirstTime;

  String _pinCode;
  String get pinCode => _$this._pinCode;
  set pinCode(String pinCode) => _$this._pinCode = pinCode;

  bool _biometryGranted;
  bool get biometryGranted => _$this._biometryGranted;
  set biometryGranted(bool biometryGranted) =>
      _$this._biometryGranted = biometryGranted;

  AsyncFieldBuilder<String> _tempCode;
  AsyncFieldBuilder<String> get tempCode =>
      _$this._tempCode ??= new AsyncFieldBuilder<String>();
  set tempCode(AsyncFieldBuilder<String> tempCode) =>
      _$this._tempCode = tempCode;

  bool _isRegistrationCompleted;
  bool get isRegistrationCompleted => _$this._isRegistrationCompleted;
  set isRegistrationCompleted(bool isRegistrationCompleted) =>
      _$this._isRegistrationCompleted = isRegistrationCompleted;

  bool _isAuthorized;
  bool get isAuthorized => _$this._isAuthorized;
  set isAuthorized(bool isAuthorized) => _$this._isAuthorized = isAuthorized;

  AppCommonStateBuilder();

  AppCommonStateBuilder get _$this {
    if (_$v != null) {
      _currentBiometricType = _$v.currentBiometricType;
      _phone = _$v.phone;
      _token = _$v.token;
      _isLaunchFirstTime = _$v.isLaunchFirstTime;
      _pinCode = _$v.pinCode;
      _biometryGranted = _$v.biometryGranted;
      _tempCode = _$v.tempCode?.toBuilder();
      _isRegistrationCompleted = _$v.isRegistrationCompleted;
      _isAuthorized = _$v.isAuthorized;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppCommonState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AppCommonState;
  }

  @override
  void update(void Function(AppCommonStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AppCommonState build() {
    _$AppCommonState _$result;
    try {
      _$result = _$v ??
          new _$AppCommonState._(
              currentBiometricType: currentBiometricType,
              phone: phone,
              token: token,
              isLaunchFirstTime: isLaunchFirstTime,
              pinCode: pinCode,
              biometryGranted: biometryGranted,
              tempCode: _tempCode?.build(),
              isRegistrationCompleted: isRegistrationCompleted,
              isAuthorized: isAuthorized);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'tempCode';
        _tempCode?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AppCommonState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
