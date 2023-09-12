import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_v2/features/user/view_models/avatar_vm.dart';

class Avatar extends ConsumerStatefulWidget {
  final String uid;
  final String name;
  final bool hasAvatar;
  const Avatar({
    super.key,
    required this.uid,
    required this.name,
    required this.hasAvatar,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AvatarState();
}

class _AvatarState extends ConsumerState<Avatar> {
  bool _loading = false;

  Future<void> _onAvatarTap() async {
    if (_loading) return;

    _loading = true;
    final xfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
      maxWidth: 400,
      maxHeight: 400,
    );
    if (xfile != null) {
      final file = File(xfile.path);
      await ref.read(avatarProvider.notifier).uploadAvatar(
            context: context,
            file: file,
          );
    }

    _loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(avatarProvider).when(
          loading: () => Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: const CircularProgressIndicator.adaptive(),
          ),
          error: (error, stackTrace) => const Center(),
          data: (data) => GestureDetector(
            onTap: _onAvatarTap,
            child: CircleAvatar(
              radius: 50,
              foregroundImage: NetworkImage(
                widget.hasAvatar
                    ? 'https://firebasestorage.googleapis.com/v0/b/tiktok-jw-v2.appspot.com/o/avatars%2F${widget.uid}?alt=media&no-cache=${DateTime.now()}'
                    : '',
              ),
              child: Text(widget.name),
            ),
          ),
        );
  }
}
