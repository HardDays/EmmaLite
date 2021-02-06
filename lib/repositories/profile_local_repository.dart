import 'package:emma_mobile/models/user/user.dart';
import 'package:emma_mobile/repositories/app_local_repository.dart';
import 'package:emma_mobile/utils/hive_boxes.dart';

class ProfileLocalRepository {
  final _hiveBoxes = HiveBoxes();
  final _appLocalRepository = AppLocalRepository();

  List<User> getUsers() {
    return _hiveBoxes.userBox.values.map((e) => e as User).toList();
  }

  User getCurrentUser() {
    final currentUserId = _appLocalRepository.getSettings().currentProfileIndex;
    return _hiveBoxes.userBox.getAt(currentUserId);
  }

  void updateUserByIndex({int index, User user}) {
    _hiveBoxes.userBox.putAt(index, user);
  }

  void addUser(User user) {
    _hiveBoxes.userBox.add(user);
  }
}
