import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_v2/features/user/models/user_profile_model.dart';

class UserRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> createUserProfile(UserProfileModel profile) async {
    _firestore.collection('users').doc(profile.uid).set(profile.toJson());
  }

  Future<Map<String, dynamic>?> findUserProfile(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    return doc.data();
  }

  Future<void> uploadAvatar(File file, String fileName) async {
    await _storage.ref().child('avatars/$fileName').putFile(file);
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _firestore.collection('users').doc(uid).update(data);
  }
}

final userProvider = Provider((ref) => UserRepo());
