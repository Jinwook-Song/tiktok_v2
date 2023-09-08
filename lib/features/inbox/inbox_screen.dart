import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_v2/constants/sizes.dart';
import 'package:tiktok_v2/routes.dart';
import 'package:tiktok_v2/utils.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  void _onDmPressed(BuildContext context) {
    context.pushNamed(Routes.chatsScreen[ScreenDef.name]!);
  }

  void _onActivityTap(BuildContext context) {
    context.pushNamed(Routes.activityScreen[ScreenDef.name]!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () => _onDmPressed(context),
            icon: const Icon(
              FontAwesomeIcons.paperPlane,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () => _onActivityTap(context),
            title: const Text(
              'Activity',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
            ),
            trailing: const Icon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size14,
            ),
          ),
          Container(
            height: Sizes.size1,
            color: isDarkMode(context)
                ? Colors.grey.shade800
                : Colors.grey.shade200,
          ),
          ListTile(
            leading: Container(
              width: Sizes.size48,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.users,
                  color: Colors.white,
                ),
              ),
            ),
            title: const Text(
              'New followers',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
            ),
            subtitle: Text(
              'Messages from followers will appear here',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: Sizes.size12,
              ),
            ),
            trailing: const Icon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size14,
            ),
          ),
        ],
      ),
    );
  }
}
