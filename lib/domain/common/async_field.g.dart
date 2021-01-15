// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'async_field.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AsyncField<T> extends AsyncField<T> {
  @override
  final T payload;
  @override
  final bool isLoading;
  @override
  final ErrorModel error;

  factory _$AsyncField([void Function(AsyncFieldBuilder<T>) updates]) =>
      (new AsyncFieldBuilder<T>()..update(updates)).build();

  _$AsyncField._({this.payload, this.isLoading, this.error}) : super._() {
    if (T == dynamic) {
      throw new BuiltValueMissingGenericsError('AsyncField', 'T');
    }
  }

  @override
  AsyncField<T> rebuild(void Function(AsyncFieldBuilder<T>) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AsyncFieldBuilder<T> toBuilder() => new AsyncFieldBuilder<T>()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AsyncField &&
        payload == other.payload &&
        isLoading == other.isLoading &&
        error == other.error;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, payload.hashCode), isLoading.hashCode), error.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AsyncField')
          ..add('payload', payload)
          ..add('isLoading', isLoading)
          ..add('error', error))
        .toString();
  }
}

class AsyncFieldBuilder<T>
    implements Builder<AsyncField<T>, AsyncFieldBuilder<T>> {
  _$AsyncField<T> _$v;

  T _payload;
  T get payload => _$this._payload;
  set payload(T payload) => _$this._payload = payload;

  bool _isLoading;
  bool get isLoading => _$this._isLoading;
  set isLoading(bool isLoading) => _$this._isLoading = isLoading;

  ErrorModelBuilder _error;
  ErrorModelBuilder get error => _$this._error ??= new ErrorModelBuilder();
  set error(ErrorModelBuilder error) => _$this._error = error;

  AsyncFieldBuilder();

  AsyncFieldBuilder<T> get _$this {
    if (_$v != null) {
      _payload = _$v.payload;
      _isLoading = _$v.isLoading;
      _error = _$v.error?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AsyncField<T> other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AsyncField<T>;
  }

  @override
  void update(void Function(AsyncFieldBuilder<T>) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AsyncField<T> build() {
    _$AsyncField<T> _$result;
    try {
      _$result = _$v ??
          new _$AsyncField<T>._(
              payload: payload, isLoading: isLoading, error: _error?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'error';
        _error?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AsyncField', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
