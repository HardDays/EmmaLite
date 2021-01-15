import 'package:bloc/bloc.dart';
import 'package:emma_mobile/bloc/profile/profile_state.dart';
import 'package:emma_mobile/domain/common/async_field.dart';
import 'package:emma_mobile/domain/model/user/user.dart';
import 'package:emma_mobile/domain/repositories/profile_repository.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.repository) : super(ProfileState());

  ProfileRepository repository;

  Future<void> fetchProfile() async {
    try {
      emit(
        state.rebuild((s) => s.user.replace(AsyncField<User>.inProgress())),
      );
      final user = await repository.fetchProfile();
      emit(
        state.rebuild((s) => s.user.replace(AsyncField<User>.success(user))),
      );
    } catch (error) {
      emit(
        state.rebuild((s) => s.user.replace(AsyncField<User>.error(error))),
      );
    }
  }
}
