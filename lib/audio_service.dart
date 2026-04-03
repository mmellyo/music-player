import 'dart:developer';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:musicplayer/notifications.dart';
AudioPlayer? _globalPlayer;


@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Initialize notifications inside service
  await initNotifications();

  // Set up stop listener FIRST
  service.on('stop').listen((_) async {
    log('Stop received!');
    await _globalPlayer?.stop();
    await _globalPlayer?.dispose();
    _globalPlayer = null;
    await cancelNotification();
    service.stopSelf();
  });

  // Show initial notification
  await showAudioNotification('🎵 Now Playing', 'music.mp3');

  // Play audio
  log('Service started: ${DateTime.now()}');
  _globalPlayer = AudioPlayer();
  try {
    await _globalPlayer!.setAsset('assets/sounds/music.mp3');
    await _globalPlayer!.play();
    log('Audio playing');

    // Update notification with current position
    _globalPlayer!.positionStream.listen((position) async {
      final minutes = position.inMinutes;
      final seconds =
      (position.inSeconds % 60).toString().padLeft(2, '0');
      await showAudioNotification(
        '🎵 Now Playing: music.mp3',
        'Playing... $minutes:$seconds',
      );
    });
  } catch (e) {
    log('Audio error: $e');
  }
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: false,
      isForegroundMode: false, // ← stays false, notification is manual
    ),
    iosConfiguration: IosConfiguration(
      autoStart: false,
      onForeground: onStart,
      onBackground: (_) => true,
    ),
  );
}
