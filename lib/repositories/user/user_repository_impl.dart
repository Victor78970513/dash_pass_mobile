import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_pass/models/user_model.dart';
import 'package:dash_pass/repositories/user/user_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UserRepositoryImpl extends UserRepository {
  FirebaseFirestore usersDb = FirebaseFirestore.instance;

  @override
  Future<bool> isNewUser(String userId) async {
    CollectionReference users = usersDb.collection("usuarios");
    final isNew = await users.doc(userId).get();
    if (isNew.exists) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<bool> createUser({
    required String uid,
    required String email,
    required String username,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) async {
    CollectionReference users = usersDb.collection("usuarios");
    DocumentSnapshot userDoc = await users.doc(uid).get();
    try {
      if (userDoc.exists) {
        return true;
      } else {
        await users.doc(uid).set({
          "name": username,
          "email": email,
          "createdAt": createdAt,
          "updatedAt": updatedAt,
          "uid": uid,
          "tarjeta_id": "",
          "saldo": 0.0,
          "vehiculo_id": "",
          "profile_picture_url": "",
        });
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<UserModel?> getUserData(String uid) async {
    CollectionReference users = usersDb.collection("usuarios");
    try {
      final response = await users.doc(uid).get();
      if (response.exists) {
        log(response.data().toString());
        return UserModel.fromMap(response.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      log("ESTE ES EL ERROR: $e");
      return null;
    }
  }

  @override
  Future<bool> updateUserData({
    required String username,
    required String profilePictureUrl,
    required String uid,
  }) async {
    try {
      Map<String, dynamic> userData = {
        "name": username,
        "updatedAt": DateTime.now(),
        "uid": uid,
        "saldo": 0.0,
        "profile_picture_url": profilePictureUrl,
      };
      await usersDb.collection("users").doc(uid).update(userData);
      return true;
    } on FirebaseException catch (e) {
      log(e.message.toString());
      return false;
    } catch (e) {
      log("ERROR AL ACTUALIZAR DATOS: $e");
      return false;
    }
  }

  @override
  Future<bool> updateUserDataForFirstTime(
      {required String uid,
      required int age,
      required double weight,
      required double height,
      required String gender,
      required String physicalLimitations,
      required String foodRestrictions,
      required String goal}) async {
    try {
      Map<String, dynamic> userData = {
        'age': age,
        'weight': weight,
        'height': height,
        'gender': gender,
        'physicalLimitations': physicalLimitations,
        'foodRestrictions': foodRestrictions,
        'goal': goal,
        'updatedAt': DateTime.now(),
      };
      await usersDb.collection("users").doc(uid).update(userData);
      return true;
    } catch (e) {
      log("ERROR AL ACTUALIZAR DATOS POR PRIMERA VEZ: $e");
      return false;
    }
  }

  @override
  Future<String> updateProfileImage(XFile imagePath) async {
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child("profile-images");
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
    await referenceImageToUpload.putFile(File(imagePath.path));
    final imageUrl = await referenceImageToUpload.getDownloadURL();
    return imageUrl;
  }

  @override
  Future<bool> changeToPremium(String uid) async {
    final CollectionReference collection = usersDb.collection("users");
    try {
      await collection.doc(uid).update({"memberType": true});
      return true;
    } catch (e) {
      return false;
    }
  }
}
