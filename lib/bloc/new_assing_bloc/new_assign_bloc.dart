
import 'package:emma_mobile/bloc/new_assing_bloc/new_assign_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class NewAssignBloc extends Cubit<NewAssignState> {
  NewAssignBloc() : super(NewAssignState());

  List<String> photos = [];

  Future<void> pickImage() async {
    final res = await ImagePicker().getImage(source: ImageSource.gallery);

    if (res != null) {
      photos.add(res.path);
    }
    emit(NewAssignState());
  }

  void deletePhoto({int index}) {
    photos.removeAt(index);
    emit(NewAssignState());
  }
}