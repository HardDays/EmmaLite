import 'package:emma_mobile/domain/model/user/user.dart';

abstract class ProfileRepository {

  Future<User> fetchProfile();
}