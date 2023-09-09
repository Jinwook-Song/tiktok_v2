import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_v2/common/widgets/theme_config/theme_config.dart';
import 'package:tiktok_v2/features/videos/view_model/video_playack_config_vm.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notification = false;

  void _onNotificationChanged(bool? notification) {
    if (notification != null) {
      setState(() {
        _notification = notification;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ValueListenableBuilder(
            valueListenable: useDarkTheme,
            builder: (context, value, child) => SwitchListTile.adaptive(
              value: value,
              onChanged: (value) {
                useDarkTheme.value = !useDarkTheme.value;
              },
              activeColor: Theme.of(context).primaryColor,
              title: const Text(
                'Dark Theme',
              ),
            ),
          ),
          SwitchListTile.adaptive(
            value: context.watch<VideoPlaybackConfigViewModel>().isMuted,
            onChanged: (value) {
              context.read<VideoPlaybackConfigViewModel>().setMuted(value);
            },
            activeColor: Theme.of(context).primaryColor,
            title: const Text(
              'Video mute by default',
            ),
          ),
          SwitchListTile.adaptive(
            value: context.watch<VideoPlaybackConfigViewModel>().isAutoplay,
            onChanged: (value) {
              context.read<VideoPlaybackConfigViewModel>().setAutoplay(value);
            },
            activeColor: Theme.of(context).primaryColor,
            title: const Text(
              'Video autoplay by default',
            ),
          ),
          CheckboxListTile.adaptive(
            value: _notification,
            onChanged: _onNotificationChanged,
            activeColor: Theme.of(context).primaryColor,
            title: const Text(
              'Enable notifications (Checkbox)',
            ),
          ),
          ListTile(
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1980),
                lastDate: DateTime(2030),
                builder: (context, child) {
                  return Theme(
                    data: ThemeData(
                      colorScheme: ColorScheme.fromSeed(
                        seedColor: Colors.white,
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (kDebugMode) print(date);
              if (!mounted) return;
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
                builder: (context, child) {
                  return Theme(
                    data: ThemeData(
                      colorScheme: ColorScheme.fromSeed(
                        seedColor: Colors.white,
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (kDebugMode) print(time);
              if (!mounted) return;
              final booking = await showDateRangePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime(2023, 8, 31),
                builder: (context, child) {
                  return Theme(
                    data: ThemeData(
                      colorScheme: ColorScheme.fromSeed(
                        seedColor: Colors.white,
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (kDebugMode) print(booking);
            },
            title: const Text('What is your birthday?'),
          ),
          ListTile(
            onTap: () => showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: const Text(
                  'Are you sure?',
                ),
                content: const Text('You can sign up later'),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () => Navigator.of(context).pop(),
                    isDestructiveAction: false,
                    child: const Text(
                      'No',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  CupertinoDialogAction(
                    onPressed: () => Navigator.of(context).pop(),
                    isDestructiveAction: true,
                    child: const Text('Yes'),
                  ),
                ],
              ),
            ),
            title: const Text(
              'Log out (IOS / Dialog)',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          ListTile(
            onTap: () => showCupertinoModalPopup(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: const Text(
                  'Are you sure?',
                ),
                content: const Text('You can sign up later'),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () => Navigator.of(context).pop(),
                    isDestructiveAction: false,
                    child: const Text(
                      'No',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  CupertinoDialogAction(
                    onPressed: () => Navigator.of(context).pop(),
                    isDestructiveAction: true,
                    child: const Text('Yes'),
                  ),
                ],
              ),
            ),
            title: const Text(
              'Log out (IOS / Popup)',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          ListTile(
            onTap: () => showCupertinoModalPopup(
              context: context,
              builder: (context) => CupertinoActionSheet(
                title: const Text(
                  'Are you sure?',
                ),
                actions: [
                  CupertinoActionSheetAction(
                    onPressed: () => Navigator.of(context).pop(),
                    isDestructiveAction: false,
                    child: const Text(
                      'No',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  CupertinoActionSheetAction(
                    onPressed: () => Navigator.of(context).pop(),
                    isDestructiveAction: true,
                    child: const Text('Yes'),
                  ),
                ],
              ),
            ),
            title: const Text(
              'Log out (IOS / Bottom sheet)',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          ListTile(
            onTap: () => showDialog(
              context: context,
              builder: (context) {
                return Theme(
                  data: ThemeData(
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: Colors.white,
                    ),
                  ),
                  child: AlertDialog(
                    title: const Text(
                      'Are you sure?',
                    ),
                    content: const Text('You can sign up later'),
                    actions: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'No',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Yes',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            title: const Text(
              'Log out (AOS)',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          ListTile(
            onTap: () => showAboutDialog(
              context: context,
              applicationVersion: '1.0.0',
              applicationLegalese: 'All rights reserved.',
            ),
            title: const Text('About'),
            subtitle: Text(
              'About this app...',
              style: TextStyle(
                color: Colors.grey.shade500,
              ),
            ),
          ),
          const AboutListTile(
            applicationVersion: '1.0.0',
            applicationLegalese: 'All rights reserved.',
          ),
        ],
      ),
    );
  }
}
