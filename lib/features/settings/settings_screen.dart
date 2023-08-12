import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
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
