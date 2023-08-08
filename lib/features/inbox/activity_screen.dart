import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_v2/constants/sizes.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final List<String> _notifications = List.generate(
    20,
    (index) => '${index}h',
  );

  void _onDismissed(String notification) {
    _notifications.removeWhere((element) => element == notification);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All activity'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
              vertical: Sizes.size10,
            ),
            child: Text(
              'New',
              style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: Sizes.size12,
                  fontWeight: FontWeight.w600),
            ),
          ),
          for (var notification in _notifications)
            Dismissible(
              key: Key(notification),
              onDismissed: (direction) => _onDismissed(notification),
              background: Container(
                padding: const EdgeInsets.only(
                  left: Sizes.size20,
                ),
                alignment: Alignment.centerLeft,
                color: Colors.green,
                child: const FaIcon(
                  FontAwesomeIcons.check,
                  size: Sizes.size20,
                  color: Colors.white,
                ),
              ),
              secondaryBackground: Container(
                padding: const EdgeInsets.only(
                  right: Sizes.size20,
                ),
                alignment: Alignment.centerRight,
                color: Colors.red,
                child: const FaIcon(
                  FontAwesomeIcons.trashCan,
                  size: Sizes.size20,
                  color: Colors.white,
                ),
              ),
              child: ListTile(
                minVerticalPadding: Sizes.size16,
                leading: Container(
                  width: Sizes.size48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: const Center(
                    child: FaIcon(FontAwesomeIcons.bell),
                  ),
                ),
                title: RichText(
                  text: TextSpan(
                    text: 'Account updates: ',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: Sizes.size14,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Upload longer videos ',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: notification,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
                trailing: const FaIcon(
                  FontAwesomeIcons.chevronRight,
                  size: Sizes.size14,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
