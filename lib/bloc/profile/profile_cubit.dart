import 'package:bloc/bloc.dart';
import 'package:emma_mobile/bloc/profile/profile_state.dart';
import 'package:emma_mobile/models/user/user.dart';
import 'package:emma_mobile/repositories/app_local_repository.dart';
import 'package:emma_mobile/repositories/profile_local_repository.dart';
import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState()) {
    _init();
  }

  final _repository = ProfileLocalRepository();

  final _appLocalRepository = AppLocalRepository();

  User _currentUser;

  List<User> _users;

  User get currentUser => _currentUser;

  List<User> get users => _users;

  Color colorIfEmpty(User user) {
    final maleColors = [
      AppColors.c7ADDFD,
      AppColors.c8DCBF8,
      AppColors.c78A6FF,
    ];
    final femaleColors = [
      AppColors.cFFC0EA,
      AppColors.cFDACC9,
      AppColors.cFFB9BD,
    ];
    final colors = user.gender == Gender.male ? maleColors : femaleColors;
    final emptyPhotos =
        users.where((e) => e.photo.isEmpty && e.gender == user.gender).toList();
    final index = emptyPhotos.lastIndexWhere((e) => e.id == user.id);
    if (index <= 2) {
      return colors[index];
    }
    final colorIndex = ((emptyPhotos.length - 1) / 3).ceil();
    return colors[colorIndex];
  }

  void _init() {
    _currentUser = _repository.getCurrentUser();
    _users = _repository.getUsers();
  }

  void setUser(User user) {
    _currentUser = user;
    final settings = _appLocalRepository.getSettings();
    settings.currentProfileId = user.id;
    _appLocalRepository.putSettings(settings);
    emit(ProfileState());
  }

  void addUser(User user) {
    if (_users.first.isEmpty) {
      user.id = _users[0].id;
      _users[0] = user;
      _repository.updateUserByIndex(index: 0, user: user);
    } else {
      _users.add(user);
      _repository.addUser(user);
    }
    emit(ProfileState());
  }

  void changeIndex({int previous, int current}) {}
}
