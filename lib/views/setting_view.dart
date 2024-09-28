import 'package:flutter/material.dart';
import 'package:note_app/themes/themes_provider.dart';
import 'package:provider/provider.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Setting Page'), elevation: 0),
      body: const SwitchWidget(),
    );
  }
}

class SwitchWidget extends StatelessWidget {
  const SwitchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemesProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              Text(
                themeProvider.isDarkMode ? 'Light Mode' : 'Dark Mode',
                style: const TextStyle(fontSize: 20),
              ),
              const Spacer(
                flex: 1,
              ),
              Switch(
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme();
                },
                activeColor: Colors.white,
                activeTrackColor: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
