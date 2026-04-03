# 🎵 Flutter Music Player

A simple but powerful **Flutter music player** that demonstrates both **UI design** and **background/foreground service concepts**. The project features a fully functional audio player with notifications and interactive controls, built to showcase both frontend and backend concepts in Flutter.

---

## 🔹 Features

- **Custom UI:**  
  Beautiful and responsive design for displaying song covers, song details, and playback controls. All UI elements including buttons, sliders, and artwork were custom-made.

- **Audio Playback:**  
  Play and stop music tracks using the [`just_audio`](https://pub.dev/packages/just_audio) package. Supports playback from local assets.

- **Background & Foreground Services:**  
  - Music continues to play even when the app is in the background.  
  - Notifications show the current playing track and update in real-time.  
  - Implemented with [`flutter_background_service`](https://pub.dev/packages/flutter_background_service).  

- **Local Notifications:**  
  Real-time playback notifications implemented with [`flutter_local_notifications`](https://pub.dev/packages/flutter_local_notifications), showing song progress and keeping the app user informed.

- **Permission Handling:**  
  Requests notification permissions using [`permission_handler`](https://pub.dev/packages/permission_handler).

---

## 🔹 Libraries Used

- [`just_audio`](https://pub.dev/packages/just_audio) – audio playback  
- [`flutter_background_service`](https://pub.dev/packages/flutter_background_service) – run background and foreground tasks  
- [`flutter_local_notifications`](https://pub.dev/packages/flutter_local_notifications) – for interactive notifications  
- [`permission_handler`](https://pub.dev/packages/permission_handler) – requesting notification permissions  
- [`flutter/cupertino.dart` & `flutter/material.dart`] – Flutter UI design components  

---

## 🔹 Project Structure

- `main.dart` – Entry point of the app, initializes services and runs the app.  
- `music_player.dart` – Contains the main `MusicPlayer` widget, UI components, and playback controls.  
- `audio_service.dart` – Handles background/foreground audio playback logic using `AudioPlayer` and Flutter background services.  
- `notifications.dart` – Handles notifications setup, updates, and cancellation.  

---

## 🔹 Usage

1. **Clone the repository:**
   ```bash
   git clone <your-repo-url>
   cd flutter_music_player
