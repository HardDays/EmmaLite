import 'package:emma_mobile/domain/model/user/user.dart';
import 'package:emma_mobile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepository)
class ProfileLocalRepository implements ProfileRepository {

  @override
  Future<User> fetchProfile() {
    final user = User(
    (s) {
      s.firstName = 'Иванов';
      s.lastName = 'Иван';
      s.phoneNumber = '+79999999999';
      s.birthDate = '20.01.2020';
      s.email = 'ivanov@mail.ru';
      s.height = 172.6;
      s.imageUrl = 'https://i.ytimg.com/vi/Y5GLCBjHR8U/maxresdefault.jpg';
      s.weight = 92.5;
      s.sex = 'male';
    }
    );
    return Future.value(user);
  }

}