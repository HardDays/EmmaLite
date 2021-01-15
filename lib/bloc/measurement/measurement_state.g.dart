// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MeasurementState extends MeasurementState {
  @override
  final AsyncField<BuiltList<Measurement>> measurementList;
  @override
  final AsyncField<BuiltList<MeasurementType>> measurementTypes;
  @override
  final AsyncField<bool> isSaved;
  @override
  final MeasurementType currentType;

  factory _$MeasurementState(
          [void Function(MeasurementStateBuilder) updates]) =>
      (new MeasurementStateBuilder()..update(updates)).build();

  _$MeasurementState._(
      {this.measurementList,
      this.measurementTypes,
      this.isSaved,
      this.currentType})
      : super._();

  @override
  MeasurementState rebuild(void Function(MeasurementStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MeasurementStateBuilder toBuilder() =>
      new MeasurementStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MeasurementState &&
        measurementList == other.measurementList &&
        measurementTypes == other.measurementTypes &&
        isSaved == other.isSaved &&
        currentType == other.currentType;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, measurementList.hashCode), measurementTypes.hashCode),
            isSaved.hashCode),
        currentType.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MeasurementState')
          ..add('measurementList', measurementList)
          ..add('measurementTypes', measurementTypes)
          ..add('isSaved', isSaved)
          ..add('currentType', currentType))
        .toString();
  }
}

class MeasurementStateBuilder
    implements Builder<MeasurementState, MeasurementStateBuilder> {
  _$MeasurementState _$v;

  AsyncFieldBuilder<BuiltList<Measurement>> _measurementList;
  AsyncFieldBuilder<BuiltList<Measurement>> get measurementList =>
      _$this._measurementList ??=
          new AsyncFieldBuilder<BuiltList<Measurement>>();
  set measurementList(
          AsyncFieldBuilder<BuiltList<Measurement>> measurementList) =>
      _$this._measurementList = measurementList;

  AsyncFieldBuilder<BuiltList<MeasurementType>> _measurementTypes;
  AsyncFieldBuilder<BuiltList<MeasurementType>> get measurementTypes =>
      _$this._measurementTypes ??=
          new AsyncFieldBuilder<BuiltList<MeasurementType>>();
  set measurementTypes(
          AsyncFieldBuilder<BuiltList<MeasurementType>> measurementTypes) =>
      _$this._measurementTypes = measurementTypes;

  AsyncFieldBuilder<bool> _isSaved;
  AsyncFieldBuilder<bool> get isSaved =>
      _$this._isSaved ??= new AsyncFieldBuilder<bool>();
  set isSaved(AsyncFieldBuilder<bool> isSaved) => _$this._isSaved = isSaved;

  MeasurementType _currentType;
  MeasurementType get currentType => _$this._currentType;
  set currentType(MeasurementType currentType) =>
      _$this._currentType = currentType;

  MeasurementStateBuilder();

  MeasurementStateBuilder get _$this {
    if (_$v != null) {
      _measurementList = _$v.measurementList?.toBuilder();
      _measurementTypes = _$v.measurementTypes?.toBuilder();
      _isSaved = _$v.isSaved?.toBuilder();
      _currentType = _$v.currentType;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MeasurementState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$MeasurementState;
  }

  @override
  void update(void Function(MeasurementStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$MeasurementState build() {
    _$MeasurementState _$result;
    try {
      _$result = _$v ??
          new _$MeasurementState._(
              measurementList: _measurementList?.build(),
              measurementTypes: _measurementTypes?.build(),
              isSaved: _isSaved?.build(),
              currentType: currentType);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'measurementList';
        _measurementList?.build();
        _$failedField = 'measurementTypes';
        _measurementTypes?.build();
        _$failedField = 'isSaved';
        _isSaved?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'MeasurementState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
