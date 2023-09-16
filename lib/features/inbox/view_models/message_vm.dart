import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_v2/features/authentication/repos/auth_repo.dart';
import 'package:tiktok_v2/features/inbox/models/message_model.dart';
import 'package:tiktok_v2/features/inbox/repos/message_repo.dart';
import 'package:tiktok_v2/utils.dart';

class MessageViewModel extends FamilyAsyncNotifier<void, String> {
  late final MessageRepo _messageRepo;
  late final String _chatRoomId;

  @override
  FutureOr<void> build(String arg) {
    _messageRepo = ref.read(messageRepo);
    _chatRoomId = arg;
  }

  Future<void> sendMessage({
    required BuildContext context,
    required String text,
  }) async {
    final uid = ref.read(authProvider).user!.uid;
    final MessageModel message = MessageModel(
      text: text,
      uid: uid,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => await _messageRepo.sendMessage(
        message: message,
        chatRoomId: _chatRoomId,
      ),
    );

    if (state.hasError) {
      showFirebaseErrorSnackBar(context, state.error);
    }
  }
}

final messageProvider =
    AsyncNotifierProvider.family<MessageViewModel, void, String>(
  () => MessageViewModel(),
);

// must return a stream
final chatProvider = StreamProvider.family<List<MessageModel>, String>(
  (ref, arg) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final chatRoomId = arg;

    return firestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('createdAt')
        .snapshots()
        .map(
          (snapshots) => snapshots.docs
              .map(
                (doc) => MessageModel.fromJson(
                  doc.data(),
                ),
              )
              .toList(),
        );
  },
);
