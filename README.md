🎵 Simple Local Music Player

A lightweight Flutter app that allows users to pick an MP3 file, view metadata, and play/pause audio using just_audio. Works on Android and Windows, with limited support on Web.

🚀 Features

📁 Pick MP3 files from local storage

🎼 Read metadata (Title, Artist, Album Art)

▶️ Play / Pause audio

⏱ Track duration & position

🎚 Seek audio using a slider

📱 Simple and clean UI

🛠 Technologies Used

Flutter

just_audio – for audio playback

file_picker – to pick local files

flutter_media_metadata – for metadata (Android/Windows)

📸 Screenshots

(Add your app screenshots here)

assets/screenshots/screen1.png
assets/screenshots/screen2.png

📦 Installation
1. Clone the repository
git clone https://github.com/Rachana16-2004/Simple-Local-Music-Player.git
cd Simple-Local-Music-Player

2. Install dependencies
flutter pub get

3. Run the app
flutter run

📂 Project Structure
lib/
 └── features/
      └── audio_player/
           ├── audio_provider.dart
           └── audio_player_screen.dart
 └── main.dart

⚠️ Notes

Metadata reading works only on Android and Windows.

On Web, metadata may return empty values.

Use MP3 files only for best performance.

🤝 Contributing

Pull requests are welcome!
If you have ideas, improvements, or bug fixes, feel free to contribute.
