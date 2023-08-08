import 'package:flutter/material.dart';
import 'package:tiktok_v2/constants/sizes.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Direct Messages'),
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        children: [
          ListTile(
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
                const Text(
                  "Nico",
                  style: TextStyle(fontWeight: FontWeight.w600),
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
            subtitle: const Text("Don't forget to make video"),
          ),
        ],
      ),
    );
  }
}
