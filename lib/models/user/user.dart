import 'package:emma_mobile/utils/utils.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 7)
class User extends HiveObject {
  @HiveField(0)
  String photo;
  @HiveField(1)
  String firstName;
  @HiveField(2)
  String lastName;
  @HiveField(3)
  int genderId;
  @HiveField(4)
  String birthday;
  @HiveField(5)
  double height;
  @HiveField(6)
  double weight;
  @HiveField(7)
  String phone;
  @HiveField(8)
  String email;
  @HiveField(9)
  int id;
  @HiveField(10)
  String status;

  User({
    this.photo,
    this.firstName,
    this.lastName,
    this.genderId,
    this.birthday,
    this.height,
    this.weight,
    this.phone,
    this.email,
    this.id,
    this.status,
  }) {
    id ??= DateTime.now().millisecondsSinceEpoch;
    photo ??= '';
    firstName ??= '';
    lastName ??= '';
    phone ??= '';
    email ??= '';
    status ??= '';
  }

  User copy() => User(
    id: id,
    height: height,
    email: email,
    photo: photo,
    phone: phone,
    lastName: lastName,
    firstName: firstName,
    birthday: birthday,
    genderId: genderId,
    status: status,
    weight: weight,
  );

  Gender get gender => genderId == null ? null : Gender.values[genderId];

  bool get isEmpty => firstName.isEmpty || lastName.isEmpty;

  DateTime get date => birthday == null ? null : DateTime.parse(birthday);

  String get initials => '${firstName.first}${lastName.first}';

  String get statusWithDefault {
    if (status.isEmpty) {
      return 'Мой профиль';
    }
    return status;
  }

  bool canSave({bool checkStatus = false}) {
    bool canSave;
    if (firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        genderId != null &&
        birthday != null &&
        height != null &&
        weight != null &&
        phone.isNotEmpty &&
        email.isNotEmpty &&
        RegExp(Constants.emailRegex).hasMatch(email)) {
      canSave = true;
    } else {
      canSave = false;
    }
    if (checkStatus) {
      if (status.isEmpty) {
        return false;
      } else {
        return canSave;
      }
    } else {
      return canSave;
    }
  }
}

enum Gender { male, female }
