import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_v2/features/videos/models/video_model.dart';

class VideoRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  UploadTask uploadVideo({
    required File video,
    required String uid,
  }) {
    return _storage
        .ref()
        .child('/videos/$uid/${DateTime.now().millisecondsSinceEpoch}')
        .putFile(video);
  }

  Future<void> createVideoDocument(VideoModel video) async {
    await _firestore.collection('videos').add(video.toJson());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchVideos() {
    return _firestore
        .collection('videos')
        .orderBy('createdAt', descending: true)
        .get();
  }
}

final videoProvider = Provider((ref) => VideoRepo());
