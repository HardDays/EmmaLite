import 'package:emma_mobile/utils/utils.dart';
import 'package:hive/hive.dart';

part 'doctor.g.dart';

@HiveType(typeId: 6)
class Doctor extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String email;
  @HiveField(3)
  String comment;
  @HiveField(4)
  int userId;

  Doctor({this.id, this.name, this.email, this.comment, this.userId}) {
    id ??= DateTime.now().millisecondsSinceEpoch;
    name ??= '';
    email ??= '';
    comment ??= '';
  }

  Doctor copyWith({String name, String email, String comment, int userId}) {
    return Doctor(
      id: id,
      name: name ?? this.name,
      comment: comment ?? this.comment,
      email: email ?? this.email,
      userId: userId ?? this.userId,
    );
  }

  bool get canSave {
    return name.isNotEmpty &&
        email.isNotEmpty &&
        RegExp(Constants.emailRegex).hasMatch(email);
  }

  bool isEqual(Doctor other) {
    return name == other?.name &&
        email == other?.email &&
        comment == other?.comment;
  }
}
