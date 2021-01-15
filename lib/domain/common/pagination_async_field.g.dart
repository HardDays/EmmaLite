// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_async_field.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PaginationAsyncField<T> extends PaginationAsyncField<T> {
  @override
  final int currentPage;
  @override
  final int perPage;
  @override
  final BuiltList<T> data;
  @override
  final bool isLoading;
  @override
  final bool isCompleted;
  @override
  final Error error;

  factory _$PaginationAsyncField(
          [void Function(PaginationAsyncFieldBuilder<T>) updates]) =>
      (new PaginationAsyncFieldBuilder<T>()..update(updates)).build();

  _$PaginationAsyncField._(
      {this.currentPage,
      this.perPage,
      this.data,
      this.isLoading,
      this.isCompleted,
      this.error})
      : super._() {
    if (T == dynamic) {
      throw new BuiltValueMissingGenericsError('PaginationAsyncField', 'T');
    }
  }

  @override
  PaginationAsyncField<T> rebuild(
          void Function(PaginationAsyncFieldBuilder<T>) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PaginationAsyncFieldBuilder<T> toBuilder() =>
      new PaginationAsyncFieldBuilder<T>()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaginationAsyncField &&
        currentPage == other.currentPage &&
        perPage == other.perPage &&
        data == other.data &&
        isLoading == other.isLoading &&
        isCompleted == other.isCompleted &&
        error == other.error;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, currentPage.hashCode), perPage.hashCode),
                    data.hashCode),
                isLoading.hashCode),
            isCompleted.hashCode),
        error.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PaginationAsyncField')
          ..add('currentPage', currentPage)
          ..add('perPage', perPage)
          ..add('data', data)
          ..add('isLoading', isLoading)
          ..add('isCompleted', isCompleted)
          ..add('error', error))
        .toString();
  }
}

class PaginationAsyncFieldBuilder<T>
    implements
        Builder<PaginationAsyncField<T>, PaginationAsyncFieldBuilder<T>> {
  _$PaginationAsyncField<T> _$v;

  int _currentPage;
  int get currentPage => _$this._currentPage;
  set currentPage(int currentPage) => _$this._currentPage = currentPage;

  int _perPage;
  int get perPage => _$this._perPage;
  set perPage(int perPage) => _$this._perPage = perPage;

  ListBuilder<T> _data;
  ListBuilder<T> get data => _$this._data ??= new ListBuilder<T>();
  set data(ListBuilder<T> data) => _$this._data = data;

  bool _isLoading;
  bool get isLoading => _$this._isLoading;
  set isLoading(bool isLoading) => _$this._isLoading = isLoading;

  bool _isCompleted;
  bool get isCompleted => _$this._isCompleted;
  set isCompleted(bool isCompleted) => _$this._isCompleted = isCompleted;

  Error _error;
  Error get error => _$this._error;
  set error(Error error) => _$this._error = error;

  PaginationAsyncFieldBuilder();

  PaginationAsyncFieldBuilder<T> get _$this {
    if (_$v != null) {
      _currentPage = _$v.currentPage;
      _perPage = _$v.perPage;
      _data = _$v.data?.toBuilder();
      _isLoading = _$v.isLoading;
      _isCompleted = _$v.isCompleted;
      _error = _$v.error;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaginationAsyncField<T> other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PaginationAsyncField<T>;
  }

  @override
  void update(void Function(PaginationAsyncFieldBuilder<T>) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PaginationAsyncField<T> build() {
    _$PaginationAsyncField<T> _$result;
    try {
      _$result = _$v ??
          new _$PaginationAsyncField<T>._(
              currentPage: currentPage,
              perPage: perPage,
              data: _data?.build(),
              isLoading: isLoading,
              isCompleted: isCompleted,
              error: error);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PaginationAsyncField', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
