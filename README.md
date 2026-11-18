# AgriConnect

AgriConnect is a Flutter mobile/web prototype for farmer profiles and farm
records. The app preserves the original Gujarati branding and dashboard
layouts.

## Run and validate

```powershell
flutter pub get
flutter run -d chrome
flutter test
flutter analyze
flutter build web
```

## Current data and service boundary

This repository does not include a server, database, authentication provider,
email/SMS sender, or live agriculture data APIs. The implemented account and
farm-record flows therefore use device/browser-local preferences so they can be
exercised offline. Accounts and farm records are kept separate by local account
on that installation/browser; they do not sync between devices.

Local storage is not a secure production identity or database system. Do not
use real passwords or sensitive personal information in this prototype.
Production authentication, password recovery, Google sign-in, and protected
multi-user data require a trusted backend and server-side authorization. Weather,
market prices, crop advisory, schemes, and support screens explicitly indicate
that their providers are not configured rather than showing fabricated results.

The app starts at the welcome screen. Registration creates a local account and
starts a session; sign-in checks that local account. Farm records can be added,
searched, edited, and deleted from the farm, crop, and irrigation sections.
