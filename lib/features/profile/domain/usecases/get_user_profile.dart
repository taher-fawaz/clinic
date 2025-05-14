import '../entities/user_entity.dart';
import '../repositories/profile_repository.dart';

class GetUserProfile {
  final ProfileRepository repository;

  GetUserProfile(this.repository);

  Future<UserEntity> call(String uid) async {
    return await repository.getUserProfile(uid);
  }
}
