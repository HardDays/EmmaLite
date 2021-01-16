import 'package:bloc/bloc.dart';
import 'package:emma_mobile/bloc/profile/profile_state.dart';
import 'package:emma_mobile/data/repositories/profile_local_repository.dart';
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.repository) : super(DataProfileState());

  ProfileLocalRepository repository;

  Future<void> fetchProfile() async {
    try {
      final user = repository.fetchProfile();
    } catch (e) {
      print(e);
      // emit(
      //   state.rebuild((s) => s.user.replace(AsyncField<User>.error(error))),
      // );
    }
  }
}
