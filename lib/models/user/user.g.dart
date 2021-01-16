// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$User extends User {
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String sex;
  @override
  final String birthDate;
  @override
  final String imageUrl;
  @override
  final double weight;
  @override
  final double height;
  @override
  final String phoneNumber;
  @override
  final String email;

  factory _$User([void Function(UserBuilder) updates]) =>
      (new UserBuilder()..update(updates)).build();

  _$User._(
      {this.firstName,
      this.lastName,
      this.sex,
      this.birthDate,
      this.imageUrl,
      this.weight,
      this.height,
      this.phoneNumber,
      this.email})
      : super._();

  @override
  User rebuild(void Function(UserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserBuilder toBuilder() => new UserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        sex == other.sex &&
        birthDate == other.birthDate &&
        imageUrl == other.imageUrl &&
        weight == other.weight &&
        height == other.height &&
        phoneNumber == other.phoneNumber &&
        email == other.email;
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
                                $jc($jc(0, firstName.hashCode),
                                    lastName.hashCode),
                                sex.hashCode),
                            birthDate.hashCode),
                        imageUrl.hashCode),
                    weight.hashCode),
                height.hashCode),
            phoneNumber.hashCode),
        email.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('User')
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('sex', sex)
          ..add('birthDate', birthDate)
          ..add('imageUrl', imageUrl)
          ..add('weight', weight)
          ..add('height', height)
          ..add('phoneNumber', phoneNumber)
          ..add('email', email))
        .toString();
  }
}

class UserBuilder implements Builder<User, UserBuilder> {
  _$User _$v;

  String _firstName;
  String get firstName => _$this._firstName;
  set firstName(String firstName) => _$this._firstName = firstName;

  String _lastName;
  String get lastName => _$this._lastName;
  set lastName(String lastName) => _$this._lastName = lastName;

  String _sex;
  String get sex => _$this._sex;
  set sex(String sex) => _$this._sex = sex;

  String _birthDate;
  String get birthDate => _$this._birthDate;
  set birthDate(String birthDate) => _$this._birthDate = birthDate;

  String _imageUrl;
  String get imageUrl => _$this._imageUrl;
  set imageUrl(String imageUrl) => _$this._imageUrl = imageUrl;

  double _weight;
  double get weight => _$this._weight;
  set weight(double weight) => _$this._weight = weight;

  double _height;
  double get height => _$this._height;
  set height(double height) => _$this._height = height;

  String _phoneNumber;
  String get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String phoneNumber) => _$this._phoneNumber = phoneNumber;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  UserBuilder();

  UserBuilder get _$this {
    if (_$v != null) {
      _firstName = _$v.firstName;
      _lastName = _$v.lastName;
      _sex = _$v.sex;
      _birthDate = _$v.birthDate;
      _imageUrl = _$v.imageUrl;
      _weight = _$v.weight;
      _height = _$v.height;
      _phoneNumber = _$v.phoneNumber;
      _email = _$v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(User other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$User;
  }

  @override
  void update(void Function(UserBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$User build() {
    final _$result = _$v ??
        new _$User._(
            firstName: firstName,
            lastName: lastName,
            sex: sex,
            birthDate: birthDate,
            imageUrl: imageUrl,
            weight: weight,
            height: height,
            phoneNumber: phoneNumber,
            email: email);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
