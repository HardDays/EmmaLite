import 'package:built_value/built_value.dart';
import 'package:emma_mobile/domain/model/common/error_model.dart';

part 'async_field.g.dart';

abstract class AsyncField<T>
    implements Built<AsyncField<T>, AsyncFieldBuilder<T>> {
  factory AsyncField([Function(AsyncFieldBuilder<T> b) updates]) =
      _$AsyncField<T>;

  AsyncField._();

  factory AsyncField.inProgress({T payload}) => AsyncField<T>((s) {
        s.payload = payload;
        s.isLoading = true;
      });

  factory AsyncField.error(ErrorModel error, {T payload}) => AsyncField<T>((s) {
        s.payload = payload;
        s.isLoading = false;
        s.error.replace(error);
      });

  factory AsyncField.success(T payload) => AsyncField<T>((s) {
        s.payload = payload;
        s.isLoading = false;
      });

  @nullable
  T get payload;

  @BuiltValueField(serialize: false)
  @nullable
  bool get isLoading;

  @BuiltValueField(serialize: false)
  @nullable
  ErrorModel get error;

  bool get hasError => error?.message?.isEmpty;

  bool get hasData => payload != null;
}
