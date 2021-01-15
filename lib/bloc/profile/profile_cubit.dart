import 'package:bloc/bloc.dart';
import 'package:emma_mobile/bloc/profile/profile_state.dart';
import 'package:emma_mobile/domain/model/user/user.dart';
import 'package:emma_mobile/domain/repositories/profile_repository.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.repository) : super(DataProfileState());

  ProfileRepository repository;

  Future<void> fetchProfile() async {
    try {
      final user = await repository.fetchProfile();
    } catch (e) {
      print(e);
      // emit(
      //   state.rebuild((s) => s.user.replace(AsyncField<User>.error(error))),
      // );
    }
  }
}
