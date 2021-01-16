import 'package:built_value/built_value.dart';

part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {
  factory User([void Function(UserBuilder) updates]) = _$User;

  User._();

  @nullable
  String get firstName;

  @nullable
  String get lastName;

  @nullable
  String get sex;

  @nullable
  String get birthDate;

  @nullable
  String get imageUrl;

  @nullable
  double get weight;

  @nullable
  double get height;

  @nullable
  String get phoneNumber;

  @nullable
  String get email;
}
