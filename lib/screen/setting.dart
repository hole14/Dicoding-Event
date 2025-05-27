import 'package:flutter/material.dart';
import 'package:dicoding_event/component/setting_card.dart';
import 'package:dicoding_event/component/theme_notifier.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appSetting = context.watch<ThemeNotifier>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
      child: Column(
        children: [
          SettingCard(
            title: 'Dark Mode',
            value: appSetting.isDarkMode,
            onChanged: appSetting.setDarkMode,
          ),
          const SizedBox(height: 16),
          SettingCard(
            title: 'Notification',
            value: appSetting.isNotificationOn,
            onChanged: appSetting.setNotification,
          ),
        ],
      ),
    );
  }
}
