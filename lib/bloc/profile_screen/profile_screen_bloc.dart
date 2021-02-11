import 'package:emma_mobile/bloc/profile_screen/profile_screen_state.dart';
import 'package:emma_mobile/models/user/user.dart';
import 'package:emma_mobile/ui/screens/crop_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/subjects.dart';

class ProfileScreenBloc extends Cubit<ProfileScreenState> {
  ProfileScreenBloc({
    User initUser,
    bool checkStatus,
  }) : super(ProfileScreenState()) {
    _user = initUser ?? User();
    _canSave = false;
    _checkStatus = checkStatus ?? false;
  }

  final _updateSubject = BehaviorSubject<bool>();

  User _user;

  bool _checkStatus;

  bool _canSave;

  User get user => _user;

  bool get canSave => _user.canSave(checkStatus: _checkStatus);

  Stream<bool> get updateStream => _updateSubject.stream.distinct();

  Future<void> pickPhoto(
      {BuildContext context, ImageSource imageSource}) async {
    final file = await ImagePicker().getImage(source: imageSource);
    if (file != null) {
      final res = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) {
            return CropScreen(path: file.path);
          },
        ),
      );
      if (res != null) {
        _user.photo = res;
        _update();
      }
    }
  }

  void deletePhoto() {
    _user.photo = '';
    _update();
  }

  void setFirstName(String s) {
    _user.firstName = s;
    _updateText();
  }

  void setLastName(String s) {
    _user.lastName = s;
    _updateText();
  }

  void setGender(Gender gender) {
    _user.genderId = gender.index;
    _update();
  }

  void setBirthday(DateTime birthDay) {
    _user.birthday = birthDay.toString();
    _update();
  }

  void setWeight(String s) {
    if (s.isEmpty) {
      _user.weight = null;
    } else {
      _user.weight = double.parse(s);
    }
    _updateText();
  }

  void setHeight(String s) {
    if (s.isEmpty) {
      _user.height = null;
    } else {
      _user.height = double.parse(s);
    }
    _updateText();
  }

  void setPhone(String phone) {
    _user.phone = phone;
    _updateText();
  }

  void setEmail(String email) {
    _user.email = email;
    _updateText();
  }

  void setStatus(String status) {
    _user.status = status;
    _updateText();
  }

  void _updateText() {
    _updateSubject.add(true);
    if (_canSave != _user.canSave(checkStatus: _checkStatus)) {
      _canSave = !_canSave;
      _update();
    }
  }

  void _update() {
    _updateSubject.add(true);
    emit(ProfileScreenState());
  }

  void closeUpdate() {
    _updateSubject.add(false);
  }

  @override
  Future<void> close() {
    _updateSubject.close();
    return super.close();
  }
}
