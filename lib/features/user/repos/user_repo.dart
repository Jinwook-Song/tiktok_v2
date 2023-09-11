import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_v2/features/user/models/user_profile_model.dart';

class UserRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUserProfile(UserProfileModel profile) async {
    _firestore.collection('users').doc(profile.uid).set(profile.toJson());
  }
}

final userProvider = Provider((ref) => UserRepo());
