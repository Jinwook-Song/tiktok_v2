import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
          SwitchListTile.adaptive(
            value: _notification,
            onChanged: _onNotificationChanged,
            activeColor: Theme.of(context).primaryColor,
            title: const Text(
              'Enable notifications (Switch)',
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
              // ignore: use_build_context_synchronously
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
              // ignore: use_build_context_synchronously
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
        ],
      ),
    );
  }
}
