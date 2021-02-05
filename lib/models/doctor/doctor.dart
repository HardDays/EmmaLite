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

  Doctor({this.id, this.name, this.email, this.comment}) {
    id ??= DateTime.now().millisecondsSinceEpoch;
    name ??= '';
    email ??= '';
    comment ??= '';
  }

  Doctor copyWith({String name, String email, String comment}) {
    return Doctor(
      id: id,
      name: name ?? this.name,
      comment: comment ?? this.comment,
      email: email ?? this.email,
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
