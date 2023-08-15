import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_v2/constants/sizes.dart';
import 'package:tiktok_v2/features/inbox/chat_detail_screen.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  final Duration _duration = const Duration(milliseconds: 300);
  final List<int> _items = [];

  void _addItem() {
    if (_key.currentState != null) {
      _key.currentState!.insertItem(_items.length, duration: _duration);
      _items.add(_items.length);
    }
  }

  void _deleteItem(int item) {
    if (_key.currentState != null) {
      _key.currentState!.removeItem(
        item,
        (context, animation) {
          return SizeTransition(
            sizeFactor: animation,
            child: Container(
              color: Theme.of(context).primaryColor,
              child: _makeListTile(item: item, deleted: true),
            ),
          );
        },
        duration: _duration,
      );

      _items.removeAt(item);
    }
  }

  void _onChatRoomTap() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ChatDetailScreen(),
    ),);
  }

  Widget _makeListTile({required int item, bool deleted = false}) {
    return ListTile(
      onTap: _onChatRoomTap,
      onLongPress: () => _deleteItem(item),
      leading: const CircleAvatar(
        radius: Sizes.size32,
        foregroundImage: NetworkImage(
          "https://avatars.githubusercontent.com/u/3612017",
        ),
        child: Text('Nico'),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "Nico ($item)",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: deleted ? Colors.white : Colors.black,),
          ),
          Text(
            "2:16 PM",
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: Sizes.size12,
            ),
          ),
        ],
      ),
      subtitle: Text(
        "Don't forget to make video",
        style: TextStyle(color: deleted ? Colors.white : Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Direct Messages'),
        elevation: 1,
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const FaIcon(
              FontAwesomeIcons.plus,
            ),
          )
        ],
      ),
      body: AnimatedList(
        key: _key,
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        itemBuilder: (context, index, animation) {
          return FadeTransition(
            key: UniqueKey(),
            opacity: animation,
            child: SizeTransition(
              sizeFactor: animation,
              child: _makeListTile(item: index),
            ),
          );
        },
      ),
    );
  }
}
