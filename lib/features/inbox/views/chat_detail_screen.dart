import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_v2/constants/gaps.dart';
import 'package:tiktok_v2/constants/sizes.dart';
import 'package:tiktok_v2/features/authentication/repos/auth_repo.dart';
import 'package:tiktok_v2/features/inbox/view_models/message_vm.dart';
import 'package:tiktok_v2/utils.dart';

class ChatDetailScreen extends ConsumerStatefulWidget {
  final String chatId;
  const ChatDetailScreen({
    super.key,
    required this.chatId,
  });

  @override
  ConsumerState<ChatDetailScreen> createState() => ChatDetailScreenState();
}

class ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  void _onSendMessageTap() async {
    final text = _textEditingController.text;
    if (text == '') return;

    await ref
        .read(messageProvider('mrkAMzrDNEfsQG74MLZk').notifier)
        .sendMessage(context: context, text: text);
    _textEditingController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        ref.watch(messageProvider('mrkAMzrDNEfsQG74MLZk')).isLoading;
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size8,
          leading: Stack(
            children: [
              const CircleAvatar(
                radius: Sizes.size24,
                foregroundImage: NetworkImage(
                  "https://avatars.githubusercontent.com/u/3612017",
                ),
                child: Text('니꼬'),
              ),
              Positioned(
                width: Sizes.size16,
                height: Sizes.size16,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: Sizes.size2,
                    ),
                    color: Colors.green,
                  ),
                ),
              )
            ],
          ),
          title: Text(
            '니꼬 (${widget.chatId})',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            'Active now',
            style: TextStyle(
              color: Colors.grey.shade500,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.flag,
                color: isDarkMode(context) ? Colors.white : Colors.black,
                size: Sizes.size20,
              ),
              Gaps.h32,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                color: isDarkMode(context) ? Colors.white : Colors.black,
                size: Sizes.size20,
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ref.watch(chatProvider('mrkAMzrDNEfsQG74MLZk')).when(
                data: (data) => ListView.separated(
                  reverse: true,
                  itemCount: data.length,
                  separatorBuilder: (context, index) => Gaps.v10,
                  padding: EdgeInsets.only(
                    left: Sizes.size14,
                    right: Sizes.size14,
                    top: Sizes.size20,
                    bottom:
                        MediaQuery.of(context).padding.bottom + Sizes.size96,
                  ),
                  itemBuilder: (context, index) {
                    final message = data[index];
                    final isMine =
                        message.uid == ref.read(authProvider).user!.uid;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: isMine
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(Sizes.size14),
                          decoration: BoxDecoration(
                            color: isMine
                                ? Colors.blue
                                : Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(
                                Sizes.size20,
                              ),
                              topRight: const Radius.circular(
                                Sizes.size20,
                              ),
                              bottomLeft: Radius.circular(
                                isMine ? Sizes.size20 : Sizes.size5,
                              ),
                              bottomRight: Radius.circular(
                                !isMine ? Sizes.size20 : Sizes.size5,
                              ),
                            ),
                          ),
                          child: Text(
                            message.text,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: Sizes.size16,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                error: (error, stackTrace) => Center(
                  child: Text(error.toString()),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: BottomAppBar(
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: Sizes.size44,
                      child: CupertinoTextField(
                        controller: _textEditingController,
                        padding: const EdgeInsets.all(Sizes.size10),
                        placeholder: 'Send a message...',
                        style: TextStyle(
                          color:
                              isDarkMode(context) ? Colors.white : Colors.black,
                        ),
                        decoration: BoxDecoration(
                          color: isDarkMode(context)
                              ? Colors.grey.shade800
                              : Colors.white,
                          borderRadius: BorderRadius.circular(
                            18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: Sizes.size48,
                    child: isLoading
                        ? const CircularProgressIndicator.adaptive()
                        : IconButton(
                            onPressed: _onSendMessageTap,
                            icon: const Icon(FontAwesomeIcons.paperPlane),
                          ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
