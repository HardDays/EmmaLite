// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ErrorModel> _$errorModelSerializer = new _$ErrorModelSerializer();

class _$ErrorModelSerializer implements StructuredSerializer<ErrorModel> {
  @override
  final Iterable<Type> types = const [ErrorModel, _$ErrorModel];
  @override
  final String wireName = 'ErrorModel';

  @override
  Iterable<Object> serialize(Serializers serializers, ErrorModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
    ];
    if (object.code != null) {
      result
        ..add('code')
        ..add(serializers.serialize(object.code,
            specifiedType: const FullType(String)));
    }
    if (object.details != null) {
      result
        ..add('details')
        ..add(serializers.serialize(object.details,
            specifiedType: const FullType(Object)));
    }
    return result;
  }

  @override
  ErrorModel deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ErrorModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'code':
          result.code = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'details':
          result.details = serializers.deserialize(value,
              specifiedType: const FullType(Object));
          break;
      }
    }

    return result.build();
  }
}

class _$ErrorModel extends ErrorModel {
  @override
  final String message;
  @override
  final String code;
  @override
  final Object details;

  factory _$ErrorModel([void Function(ErrorModelBuilder) updates]) =>
      (new ErrorModelBuilder()..update(updates)).build();

  _$ErrorModel._({this.message, this.code, this.details}) : super._() {
    if (message == null) {
      throw new BuiltValueNullFieldError('ErrorModel', 'message');
    }
  }

  @override
  ErrorModel rebuild(void Function(ErrorModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ErrorModelBuilder toBuilder() => new ErrorModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ErrorModel &&
        message == other.message &&
        code == other.code &&
        details == other.details;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, message.hashCode), code.hashCode), details.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ErrorModel')
          ..add('message', message)
          ..add('code', code)
          ..add('details', details))
        .toString();
  }
}

class ErrorModelBuilder implements Builder<ErrorModel, ErrorModelBuilder> {
  _$ErrorModel _$v;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  String _code;
  String get code => _$this._code;
  set code(String code) => _$this._code = code;

  Object _details;
  Object get details => _$this._details;
  set details(Object details) => _$this._details = details;

  ErrorModelBuilder();

  ErrorModelBuilder get _$this {
    if (_$v != null) {
      _message = _$v.message;
      _code = _$v.code;
      _details = _$v.details;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ErrorModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ErrorModel;
  }

  @override
  void update(void Function(ErrorModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ErrorModel build() {
    final _$result = _$v ??
        new _$ErrorModel._(message: message, code: code, details: details);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
