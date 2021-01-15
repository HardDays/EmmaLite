// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MainState extends MainState {
  @override
  final AsyncField<BuiltList<Measurement>> measurementList;

  factory _$MainState([void Function(MainStateBuilder) updates]) =>
      (new MainStateBuilder()..update(updates)).build();

  _$MainState._({this.measurementList}) : super._();

  @override
  MainState rebuild(void Function(MainStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MainStateBuilder toBuilder() => new MainStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MainState && measurementList == other.measurementList;
  }

  @override
  int get hashCode {
    return $jf($jc(0, measurementList.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MainState')
          ..add('measurementList', measurementList))
        .toString();
  }
}

class MainStateBuilder implements Builder<MainState, MainStateBuilder> {
  _$MainState _$v;

  AsyncFieldBuilder<BuiltList<Measurement>> _measurementList;
  AsyncFieldBuilder<BuiltList<Measurement>> get measurementList =>
      _$this._measurementList ??=
          new AsyncFieldBuilder<BuiltList<Measurement>>();
  set measurementList(
          AsyncFieldBuilder<BuiltList<Measurement>> measurementList) =>
      _$this._measurementList = measurementList;

  MainStateBuilder();

  MainStateBuilder get _$this {
    if (_$v != null) {
      _measurementList = _$v.measurementList?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MainState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$MainState;
  }

  @override
  void update(void Function(MainStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$MainState build() {
    _$MainState _$result;
    try {
      _$result =
          _$v ?? new _$MainState._(measurementList: _measurementList?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'measurementList';
        _measurementList?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'MainState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
