# Flutter Interview Test Task

This project is a Flutter interview task implementing the main requested flow:
- Home screen
- Calendar screen
- Mood screen
- Profile screen

## 1) Dependencies Used & Why

### Main Dependencies

- `flutter_riverpod`: Used for state management with clear, testable providers/controllers across features (navigation, home, calendar, mood).
- `flutter_screenutil`: Used to make spacing, sizing, and font scale responsive across different device screen sizes.
- `flutter_svg`: Used to render SVG assets from `assets/icons/`.
- `intl`: Used for date and time formatting in UI labels and calendar-related text.
- `cupertino_icons`: Used for iOS-style icon support where needed.

### Dev Dependencies

- `flutter_test`: Used for widget and unit testing.
- `flutter_lints`: Used to enforce recommended Flutter/Dart lint rules and keep code quality consistent.

## 2) Project Structure

The project uses a feature-first structure, with shared modules in `core` and feature modules in `features`.

```text
.
├── assets/
│   └── icons/                     # SVG and icon assets used by the app
├── lib/
│   ├── app/                       # App-level setup (MaterialApp and top-level wiring)
│   ├── core/                      # Shared constants, theme, widgets, and utilities
│   │   ├── constants/
│   │   ├── theme/
│   │   ├── utils/
│   │   └── widgets/
│   ├── features/                  # Feature modules
│   │   ├── navigation/
│   │   │   ├── application/
│   │   │   └── presentation/
│   │   ├── home/
│   │   │   ├── application/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   ├── calendar/
│   │   │   ├── application/
│   │   │   └── presentation/
│   │   ├── mood/
│   │   │   ├── application/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   └── profile/
│   │       └── presentation/
│   └── main.dart                  # App entry point
├── screenshots/                   # App screenshots for README links
└── test/                          # Widget and unit tests
```

## 3) App Screenshots

Add all screenshots inside the `screenshots/` folder, then keep one folder link here:

- [View Screenshots](https://github.com/aliismaildev/test_task/tree/main/screenshots)

## 4) App Video

- [Watch App Demo Video](https://drive.google.com/file/d/133tbGp75TZmz_tUSdqJWubM5A0G4cM-p/view?usp=sharing)

## 5) App APK

- [Download APK](https://drive.google.com/file/d/13lQuMlupUAaaIl_NJOQR29pfAWkcOB9I/view?usp=sharing)

## Run Locally

```bash
flutter pub get
flutter run
```

## Run Tests

```bash
flutter test
```
