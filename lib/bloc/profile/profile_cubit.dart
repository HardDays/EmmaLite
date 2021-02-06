import 'package:bloc/bloc.dart';
import 'package:emma_mobile/bloc/profile/profile_state.dart';
import 'package:emma_mobile/models/user/user.dart';
import 'package:emma_mobile/repositories/profile_local_repository.dart';


class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState()) {
    if (_repository.getUsers().isEmpty) {
      _repository.addUser(User());
    }
    _init();
  }

  final _repository = ProfileLocalRepository();

  User _currentUser;

  List<User> _users;

  User get currentUser => _currentUser;

  List<User> get users => _users;

  void _init() {
    _currentUser = _repository.getCurrentUser();
    _users = _repository.getUsers();
  }

  void setUser(User user) {
    _currentUser = user;
    emit(ProfileState());
  }

  void addUser(User user) {
    _currentUser = user;
    if (_users.first.isEmpty) {
      _users[0] = user;
      _repository.updateUserByIndex(index: 0, user: user);
    }
    emit(ProfileState());
  }
}
