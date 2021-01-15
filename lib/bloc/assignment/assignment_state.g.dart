// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AssignmentState extends AssignmentState {
  @override
  final AsyncField<BuiltList<Assignment>> assignmentList;
  @override
  final BuiltList<String> assignmentTypes;
  @override
  final BuiltList<String> unitsName;
  @override
  final BuiltList<String> frequencies;
  @override
  final BuiltList<String> periodicity;
  @override
  final String currentTypeChip;
  @override
  final BuiltList<String> assignChipTypes;

  factory _$AssignmentState([void Function(AssignmentStateBuilder) updates]) =>
      (new AssignmentStateBuilder()..update(updates)).build();

  _$AssignmentState._(
      {this.assignmentList,
      this.assignmentTypes,
      this.unitsName,
      this.frequencies,
      this.periodicity,
      this.currentTypeChip,
      this.assignChipTypes})
      : super._();

  @override
  AssignmentState rebuild(void Function(AssignmentStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AssignmentStateBuilder toBuilder() =>
      new AssignmentStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AssignmentState &&
        assignmentList == other.assignmentList &&
        assignmentTypes == other.assignmentTypes &&
        unitsName == other.unitsName &&
        frequencies == other.frequencies &&
        periodicity == other.periodicity &&
        currentTypeChip == other.currentTypeChip &&
        assignChipTypes == other.assignChipTypes;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc(0, assignmentList.hashCode),
                            assignmentTypes.hashCode),
                        unitsName.hashCode),
                    frequencies.hashCode),
                periodicity.hashCode),
            currentTypeChip.hashCode),
        assignChipTypes.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AssignmentState')
          ..add('assignmentList', assignmentList)
          ..add('assignmentTypes', assignmentTypes)
          ..add('unitsName', unitsName)
          ..add('frequencies', frequencies)
          ..add('periodicity', periodicity)
          ..add('currentTypeChip', currentTypeChip)
          ..add('assignChipTypes', assignChipTypes))
        .toString();
  }
}

class AssignmentStateBuilder
    implements Builder<AssignmentState, AssignmentStateBuilder> {
  _$AssignmentState _$v;

  AsyncFieldBuilder<BuiltList<Assignment>> _assignmentList;
  AsyncFieldBuilder<BuiltList<Assignment>> get assignmentList =>
      _$this._assignmentList ??= new AsyncFieldBuilder<BuiltList<Assignment>>();
  set assignmentList(AsyncFieldBuilder<BuiltList<Assignment>> assignmentList) =>
      _$this._assignmentList = assignmentList;

  ListBuilder<String> _assignmentTypes;
  ListBuilder<String> get assignmentTypes =>
      _$this._assignmentTypes ??= new ListBuilder<String>();
  set assignmentTypes(ListBuilder<String> assignmentTypes) =>
      _$this._assignmentTypes = assignmentTypes;

  ListBuilder<String> _unitsName;
  ListBuilder<String> get unitsName =>
      _$this._unitsName ??= new ListBuilder<String>();
  set unitsName(ListBuilder<String> unitsName) => _$this._unitsName = unitsName;

  ListBuilder<String> _frequencies;
  ListBuilder<String> get frequencies =>
      _$this._frequencies ??= new ListBuilder<String>();
  set frequencies(ListBuilder<String> frequencies) =>
      _$this._frequencies = frequencies;

  ListBuilder<String> _periodicity;
  ListBuilder<String> get periodicity =>
      _$this._periodicity ??= new ListBuilder<String>();
  set periodicity(ListBuilder<String> periodicity) =>
      _$this._periodicity = periodicity;

  String _currentTypeChip;
  String get currentTypeChip => _$this._currentTypeChip;
  set currentTypeChip(String currentTypeChip) =>
      _$this._currentTypeChip = currentTypeChip;

  ListBuilder<String> _assignChipTypes;
  ListBuilder<String> get assignChipTypes =>
      _$this._assignChipTypes ??= new ListBuilder<String>();
  set assignChipTypes(ListBuilder<String> assignChipTypes) =>
      _$this._assignChipTypes = assignChipTypes;

  AssignmentStateBuilder();

  AssignmentStateBuilder get _$this {
    if (_$v != null) {
      _assignmentList = _$v.assignmentList?.toBuilder();
      _assignmentTypes = _$v.assignmentTypes?.toBuilder();
      _unitsName = _$v.unitsName?.toBuilder();
      _frequencies = _$v.frequencies?.toBuilder();
      _periodicity = _$v.periodicity?.toBuilder();
      _currentTypeChip = _$v.currentTypeChip;
      _assignChipTypes = _$v.assignChipTypes?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AssignmentState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AssignmentState;
  }

  @override
  void update(void Function(AssignmentStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AssignmentState build() {
    _$AssignmentState _$result;
    try {
      _$result = _$v ??
          new _$AssignmentState._(
              assignmentList: _assignmentList?.build(),
              assignmentTypes: _assignmentTypes?.build(),
              unitsName: _unitsName?.build(),
              frequencies: _frequencies?.build(),
              periodicity: _periodicity?.build(),
              currentTypeChip: currentTypeChip,
              assignChipTypes: _assignChipTypes?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'assignmentList';
        _assignmentList?.build();
        _$failedField = 'assignmentTypes';
        _assignmentTypes?.build();
        _$failedField = 'unitsName';
        _unitsName?.build();
        _$failedField = 'frequencies';
        _frequencies?.build();
        _$failedField = 'periodicity';
        _periodicity?.build();

        _$failedField = 'assignChipTypes';
        _assignChipTypes?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AssignmentState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
