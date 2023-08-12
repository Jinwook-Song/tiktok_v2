import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListWheelScrollView(
        itemExtent: 200,
        offAxisFraction: 1,
        diameterRatio: 5,
        children: [
          for (var x in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
            FractionallySizedBox(
              widthFactor: 1,
              child: Container(
                alignment: Alignment.center,
                color: Colors.amber[100 * (x % 10)],
                child: const Text(
                  'options',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
