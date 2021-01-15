import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'pagination_async_field.g.dart';

abstract class PaginationAsyncField<T>
    implements Built<PaginationAsyncField<T>, PaginationAsyncFieldBuilder<T>> {
  factory PaginationAsyncField(
          [void Function(PaginationAsyncFieldBuilder<T>) updates]) =
      _$PaginationAsyncField<T>;

  PaginationAsyncField._();

  @nullable
  int get currentPage;

  @nullable
  int get perPage;

  @nullable
  BuiltList<T> get data;

  @nullable
  bool get isLoading;

  @nullable
  bool get isCompleted;

  bool get hasData => data != null || isCompleted == true;

  @nullable
  Error get error;

  PaginationAsyncField<T> setLoading({bool isLoading}) => rebuild((a) => a
    ..isLoading = isLoading
    ..isCompleted = false
    ..error = null);

  PaginationAsyncField<T> setError(Error error) => rebuild((a) => a
    ..isLoading = false
    ..error = error);

  PaginationAsyncField<T> addData(int fromPage, Iterable<T> data) {
    return rebuild((a) {
      a
        ..isLoading = false
        ..error = null
        ..currentPage = fromPage;
      if (data != null && data.isNotEmpty) {
        a.data.addAll(data);
      } else {
        a.isCompleted = true;
      }
    });
  }
}
