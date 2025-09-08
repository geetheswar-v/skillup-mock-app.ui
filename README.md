# SkillUP UI Prototype

Demo-ready Flutter UI for an AI-powered mock testing platform for CAT & GATE aspirants.

## Features

- Adaptive layouts: AppBar + BottomNavigationBar (mobile) and desktop header nav
- Pages: Onboarding (mobile), Login, Dashboard, Tests, Analysis (charts), Account, Subscription, Exam Mode
- Theme: Light/Dark/System with local persistence
- Demo auth: OAuth-style buttons that route to dashboard
- Exam Mode: timer, question navigation, and a demo security overlay

## Run

1. Fetch deps
   - `flutter pub get`
2. Run app
   - `flutter run -d chrome` or `flutter run -d linux` or a connected device

## Notes

- Backend flows are mocked; navigation demonstrates end-to-end UX
- Charts use `fl_chart` with placeholder data
- State managed with `provider`; preferences with `shared_preferences`
