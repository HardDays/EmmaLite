import 'package:built_value/built_value.dart';
import 'package:emma_mobile/domain/common/async_field.dart';
import 'package:emma_mobile/domain/model/user/user.dart';

part 'profile_state.g.dart';

abstract class ProfileState
    implements Built<ProfileState, ProfileStateBuilder> {
  factory ProfileState([void Function(ProfileStateBuilder) updates]) =
      _$ProfileState;

  ProfileState._();

  @nullable
  AsyncField<User> get user;
}
