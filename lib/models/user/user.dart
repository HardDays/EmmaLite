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
  }

  Gender get gender => genderId == null ? null : Gender.values[genderId];

  bool get isEmpty => firstName.isEmpty || lastName.isEmpty;

  DateTime get date => birthday == null ? null : DateTime.parse(birthday);

  bool get canSave {
    if (firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        genderId != null &&
        birthday != null &&
        height != null &&
        weight != null &&
        phone.isNotEmpty &&
        email.isNotEmpty) {
      return true;
    }
    return false;
  }
}

enum Gender { male, female }
