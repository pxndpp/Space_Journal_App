# 🚀 Space Journal App

> A Flutter application for exploring and journaling NASA space stories — built with a sleek dark space aesthetic and local-first storage.

---

## ✨ Features

- 📰 **NASA Story Feed** — Browse space stories and media fetched from the NASA API
- 📓 **Personal Journal** — Save and manage your own space-themed journal entries locally
- 💾 **Offline-First** — All journal data is stored locally using Hive (no account needed)
- 🎨 **Space-Themed UI** — Deep dark theme (`#1A1A2E`) with Google Fonts and custom branding
- 🌍 **Cross-Platform** — Runs on Android, iOS, Web, Windows, macOS, and Linux

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Framework | [Flutter](https://flutter.dev/) 3.x (Dart SDK ^3.10.8) |
| Local Database | [Hive CE](https://pub.dev/packages/hive_ce) + hive_ce_flutter |
| Networking | [http](https://pub.dev/packages/http) |
| Env Config | [flutter_dotenv](https://pub.dev/packages/flutter_dotenv) |
| Fonts | [google_fonts](https://pub.dev/packages/google_fonts) |
| Date Formatting | [intl](https://pub.dev/packages/intl) |
| Splash Screen | [flutter_native_splash](https://pub.dev/packages/flutter_native_splash) |

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (version 3.x or higher)
- A [NASA API key](https://api.nasa.gov/) (free)
- Dart SDK `^3.10.8`

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/pxndpp/Space_Journal_App.git
   cd Space_Journal_App
   ```

2. **Set up your environment variables**

   Create a `.env` file in the project root:

   ```env
   NASA_API_KEY=your_nasa_api_key_here
   ```

3. **Install dependencies**

   ```bash
   flutter pub get
   ```

4. **Generate Hive adapters**

   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

5. **Run the app**

   ```bash
   flutter run
   ```

---

## 📁 Project Structure

```
Space_Journal_App/
├── lib/                  # Dart source code
├── assets/               # Images and logos
│   ├── Space_logo.png
│   ├── Space_logo_alt.png
│   └── Space_logo_bar.png
├── android/              # Android platform config
├── ios/                  # iOS platform config
├── web/                  # Web platform config
├── windows/              # Windows platform config
├── linux/                # Linux platform config
├── macos/                # macOS platform config
├── test/                 # Unit & widget tests
├── .env                  # API keys (not committed)
└── pubspec.yaml          # Project dependencies
```

---

## ⚙️ Configuration

The app reads secrets from a `.env` file at the project root using `flutter_dotenv`. Make sure the file exists before running — it is listed in `.gitignore` and should **never** be committed.

```env
NASA_API_KEY=DEMO_KEY   # Replace with your own key from https://api.nasa.gov/
```

---

## 🧪 Running Tests

```bash
flutter test
```

---

## 📦 Building for Release

**Android APK:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

**Web:**
```bash
flutter build web --release
```

---

## 📄 License

This project is open source. See the repository for details.

---

## 👤 Author

**Suwaphat Lamaisakun (pxndpp)**
- GitHub: [@pxndpp](https://github.com/pxndpp)

---

*Made with ❤️ and a love for space exploration.*