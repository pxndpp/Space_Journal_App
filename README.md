# 🚀 Space Journal

> A Flutter mobile app that brings the universe to your fingertips — powered by NASA's Astronomy Picture of the Day (APOD) API.

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-^3.10.8-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/license-Private-red)](LICENSE)
[![Version](https://img.shields.io/badge/version-1.0.0-brightgreen)]()

---

## 📖 Overview

**Space Journal** is a beautifully designed Flutter application that lets you explore a different piece of the cosmos every day. Powered by [NASA's APOD API](https://api.nasa.gov/), the app fetches stunning astronomy images and their scientific explanations. You can save your favorite space pictures to a personal journal, add your own notes, and revisit them anytime — all stored locally on your device.

---

## ✨ Features

| Feature | Description |
|---|---|
| 🌌 **Daily Space Image** | Fetches today's NASA Astronomy Picture of the Day on launch |
| 📅 **Date Picker** | Browse any APOD entry from **June 16, 1995** (the very first APOD) to today |
| 💾 **Save to Journal** | Save any space picture with a personal note to your device |
| 📓 **My Journal** | View all saved entries in a scrollable list with thumbnail previews |
| ✏️ **Edit Notes** | Update the personal note attached to any saved entry |
| 🗑️ **Delete Entries** | Remove unwanted entries with a confirmation dialog |
| 🖼️ **Detail View** | Full-screen image view for saved entries with Hero transition animations |
| 📴 **Offline Storage** | All journal data is stored locally using Hive — no account needed |
| 🎨 **Space-themed UI** | Deep purple/pink gradient aesthetic with Google Fonts (Exo 2 & Space Mono) |
| 💫 **Splash Screen** | Custom branded splash screen with the Space Journal logo |

---

## 📱 Screens

### 1. Home Screen
The main screen of the app. On launch, it automatically fetches the latest APOD and displays it inside a `SpaceCard`. From here you can:
- View the image, title, date, explanation, and copyright credit
- Pick a different date using the calendar icon
- Save the entry to your journal (heart icon opens a note input modal)
- Navigate to **My Journal** using the book icon in the top-right corner

### 2. My Journal (Favorites Screen)
A list of all your saved space journal entries. Each item shows:
- A thumbnail of the astronomy image
- The title and date of the entry
- Edit (✏️) and Delete (🗑️) action buttons

Tapping an entry navigates to the **Detail View** with a smooth Hero animation.

### 3. Note Detail Screen
A full-screen, dark-themed view of a saved entry showing:
- The full-width astronomy image (Hero transition from the list)
- The entry title styled with Space Mono font
- Your personal note

---

## 🏗️ Project Structure

```
lib/
├── main.dart                     # App entry point, Hive & theme setup
├── hive_registrar.g.dart         # Auto-generated Hive adapter registry
│
├── models/
│   ├── apod_entry.dart           # Data model for a NASA APOD response
│   ├── favorite_note.dart        # Hive model for a saved journal entry
│   └── favorite_note.g.dart      # Auto-generated Hive TypeAdapter
│
├── screens/
│   ├── home_screen.dart          # Main screen — APOD viewer & date picker
│   ├── favorite_screen.dart      # Journal list — saved entries
│   └── note_detail_screen.dart   # Full detail view for a saved entry
│
├── services/
│   ├── api_service.dart          # NASA APOD API client (HTTP)
│   └── database_service.dart     # Hive CRUD operations
│
└── widgets/
    ├── SpaceCard.dart            # Reusable card widget for displaying APOD data
    └── custom_input_modal.dart   # Bottom sheet modal for note input/editing

assets/
├── Space_logo.png                # Splash screen image
├── Space_logo_alt.png            # Alternate logo
└── Space_logo_bar.png            # App bar title image
```

---

## 🛠️ Tech Stack

| Package | Version | Purpose |
|---|---|---|
| `flutter` | SDK | UI framework |
| `http` | ^1.6.0 | NASA API HTTP requests |
| `flutter_dotenv` | ^6.0.0 | Secure API key management via `.env` |
| `hive_ce` | ^2.19.3 | Local NoSQL database for journal storage |
| `hive_ce_flutter` | ^2.3.4 | Flutter integration for Hive CE |
| `google_fonts` | ^8.0.2 | Exo 2 (body) & Space Mono (detail) fonts |
| `hexcolor` | ^3.1.3 | Hex color string support |
| `intl` | ^0.20.2 | Date formatting (`yyyy-MM-dd`) |
| `flutter_native_splash` | ^2.4.7 | Custom splash screen |
| `cupertino_icons` | ^1.0.9 | iOS-style icons |

**Dev Dependencies:**

| Package | Version | Purpose |
|---|---|---|
| `build_runner` | ^2.13.1 | Code generation runner |
| `hive_ce_generator` | ^1.11.1 | Generates Hive TypeAdapters |
| `flutter_lints` | ^6.0.0 | Dart lint rules |

---

## ⚙️ Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) **3.x or later**
- Dart SDK **^3.10.8**
- A valid **NASA API Key** — get one free at [https://api.nasa.gov/](https://api.nasa.gov/)
- An Android emulator / physical device, or iOS Simulator / device

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/pxndpp/Space_Journal_App.git
cd Space_Journal_App
```

### 2. Configure Environment Variables

The app loads the NASA API key from a `.env` file at the project root. Create it:

```env
# .env  (place at the project root — same level as pubspec.yaml)
NASA_API_KEY=your_nasa_api_key_here
```

> **⚠️ Important:** The `.env` file is declared as a Flutter asset in `pubspec.yaml`. Do **not** commit it to version control. Make sure `.env` is in your `.gitignore`.
>
> If no key is provided, the app falls back to `DEMO_KEY`, which has a rate limit of **30 requests/hour per IP**.

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Generate Hive Adapters

The `FavoriteNote` model uses Hive's code generation. Run this once (and again after any model changes):

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 5. Generate the Splash Screen

```bash
dart run flutter_native_splash:create
```

### 6. Run the App

```bash
flutter run
```

---

## 🔑 API Reference

The app integrates with NASA's [Astronomy Picture of the Day (APOD)](https://apod.nasa.gov/apod/astropix.html) endpoint.

**Base URL:** `https://api.nasa.gov/planetary/apod`

| Parameter | Type | Description |
|---|---|---|
| `api_key` | `string` | Your NASA API key (or `DEMO_KEY`) |
| `date` | `string` | Optional. Date in `YYYY-MM-DD` format. Defaults to today. |

**Example Request:**
```
GET https://api.nasa.gov/planetary/apod?api_key=YOUR_KEY&date=2024-07-04
```

**Response Fields Used by the App:**

| JSON Field | Model Property | Description |
|---|---|---|
| `title` | `ApodEntry.title` | Title of the astronomy image |
| `date` | `ApodEntry.date` | Date of the entry (also used as the Hive key) |
| `explanation` | `ApodEntry.explanation` | Scientific description |
| `url` | `ApodEntry.imgURL` | URL of the image or video |
| `copyright` | `ApodEntry.copyright` | Image credit |

> **Note:** On some dates the APOD may be a video (e.g., a YouTube embed). The `SpaceCard` widget handles this gracefully by showing a broken-image icon via `errorBuilder`.

---

## 💾 Local Database (Hive)

All journal data is persisted offline using **Hive CE**, a lightweight key-value store.

- **Box name:** `fav_noted_Box`
- **Key:** `FavoriteNote.date` — a `YYYY-MM-DD` string, guaranteed unique per entry

| Operation | Method | Description |
|---|---|---|
| Create / Update | `DatabaseService.saveNote(note)` | Upsert a note using date as key |
| Read All | `DatabaseService.getAllNote()` | Returns all saved notes as a `List` |
| Delete | `DatabaseService.deleteNote(date)` | Delete an entry by date key |
| Check Saved | `DatabaseService.isSaved(date)` | Returns `true` if the entry exists |

---

## 🎨 Design System

**Color Palette:**

| Name | Hex | Usage |
|---|---|---|
| Deep Pink | `#D3045D` | Gradient accent (AppBar, Body) |
| Lavender | `#C77DFF` | Gradient midpoint |
| Deep Blue | `#0C287B` | Gradient end / calendar icon |
| Space Black | `#0B0B1E` | Journal & detail screen background |
| Dark Navy | `#1A0B2E` / `#2D1B4E` | Journal background gradient |
| Soft Lavender | `#F0E6FF` | Text on dark backgrounds |
| Purple Text | `#E0AAFF` | Detail screen title & back button icon |

**Typography:**

| Font | Usage |
|---|---|
| **Exo 2** (Google Fonts) | Global body font — set in `ThemeData` |
| **Space Mono** (Google Fonts) | Detail screen — monospaced, technical aesthetic |

**Animations:**

- **Hero transitions** — Shared-element animation between the journal list thumbnail and the full detail image, keyed by each entry's unique date string.

---

## 📦 Building for Release

**Android APK:**
```bash
flutter build apk --release
```

**Android App Bundle (for Play Store):**
```bash
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

---

## 🧪 Running Tests

```bash
flutter test
```

---

## 📋 Known Limitations

- **Video entries:** When the APOD is a video rather than an image (e.g., a YouTube embed), `SpaceCard` cannot render it and falls back to a broken-image icon. Video playback is not currently supported.
- **Rate limiting:** The `DEMO_KEY` fallback is limited to 30 requests/hour per IP. Use a personal API key to avoid `503` errors.
- **Error state:** API errors show a friendly message along with a date-picker shortcut so the user can immediately try a different date.

---

## 🤝 Contributing

This is a private project. To contribute if you have access:

1. Create a new branch from `main`
2. Make your changes
3. Run `dart run build_runner build --delete-conflicting-outputs` if any Hive models were changed
4. Verify with `flutter analyze` and `flutter test`
5. Open a pull request with a clear description of your changes

---

## 👤 Author

**pxndpp**
- GitHub: [@pxndpp](https://github.com/pxndpp)

---

## 📄 License

This project is private and not licensed for public distribution.

---

*Made with ❤️ and a love for the cosmos.*
