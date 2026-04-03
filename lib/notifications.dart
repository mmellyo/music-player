// lib/notifications.dart
import 'dart:developer';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin notificationsPlugin =
FlutterLocalNotificationsPlugin();

// Initialize notification plugin
Future<void> initNotifications() async {
  const AndroidInitializationSettings androidSettings =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initSettings =
  InitializationSettings(android: androidSettings);
  await notificationsPlugin.initialize(initSettings);
}

// Show/update notification
Future<void> showAudioNotification(String title, String content) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'audio_channel',
    'Audio Playback',
    channelDescription: 'Shows currently playing audio',
    importance: Importance.low,
    priority: Priority.low,
    ongoing: true,
    playSound: false,
    icon: '@mipmap/ic_launcher',
  );
  const NotificationDetails details =
  NotificationDetails(android: androidDetails);
  await notificationsPlugin.show(888, title, content, details);
}

// Cancel notification
Future<void> cancelNotification() async {
  await notificationsPlugin.cancel(888);
}