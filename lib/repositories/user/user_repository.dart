import 'package:dash_pass/models/user_model.dart';
import 'package:image_picker/image_picker.dart';

abstract class UserRepository {
  Future<bool> changeToPremium(String uid);

  Future<bool> createUser({
    required String uid,
    required String email,
    required String username,
    required DateTime createdAt,
    required DateTime updatedAt,
    required int carnet,
    required int telefono,
  });
  Future<UserModel?> getUserData(String uid);

  Future<bool> updateUserData({
    required String username,
    required String profilePictureUrl,
    required String uid,
  });

  Future<bool> updateUserDataForFirstTime({
    required String uid,
    required int age,
    required double weight,
    required double height,
    required String gender,
    required String physicalLimitations,
    required String foodRestrictions,
    required String goal,
  });

  Future<String> updateProfileImage(XFile imagePath);

  Future<bool> isNewUser(String userId);
}
