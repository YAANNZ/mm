# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a hybrid iOS/Flutter application for an AI music platform. It has two main components:
- `mm/` — Native iOS app (Swift/Objective-C) handling audio playback, video, photo, and score modules
- `mm_flutter/` — Flutter module embedded in the native app, handling authentication and main UI

## Common Commands

### Flutter (in `mm_flutter/`)
```bash
flutter pub get                        # Install dependencies
dart run build_runner build            # Regenerate json_serializable code (*.g.dart)
dart run build_runner watch            # Watch mode for code generation
flutter run                            # Run Flutter app standalone
flutter test                           # Run Flutter tests
flutter test test/widget_test.dart     # Run a single test file
```

### iOS Native (in `mm/`)
```bash
pod install                            # Install/update CocoaPods dependencies
open mm.xcworkspace                    # Open in Xcode (always use .xcworkspace, not .xcodeproj)
```

## Architecture

### Flutter Module (`mm_flutter/lib/`)

**State Management:** Provider pattern with `ChangeNotifier`.

**Layer structure:**
- `models/` — Data classes with `json_serializable` code gen. Run `build_runner` after modifying models with `@JsonSerializable`.
- `services/` — `ApiService` singleton handles all HTTP calls to the backend (`http://localhost:8080/api`). Returns `ApiResponse<T>` generic wrapper. Stores JWT token in `SharedPreferences`. Auto-clears token on 401.
- `providers/` — `AuthProvider` wraps `ApiService`, manages auth state (`isLoggedIn`, `user`, `isLoading`, `error`), and exposes actions (`login`, `register`, `logout`).
- `screens/` — UI screens. `SplashScreen` performs the initial auth check; `LoginScreen`/`RegisterScreen` handle auth flows; `HomeScreen` is the post-login landing.

**Navigation:** Declared `go_router` dependency but navigation is currently done with `Navigator.pushReplacementNamed`. Routes are defined in `main.dart`.

**Backend API base URL:** `http://localhost:8080/api` — configured in `lib/services/api_service.dart`.

### Native iOS Module (`mm/`)

Uses `CTMediator` for cross-module communication between native modules (audio, video, photo, score). ReactiveObjC/ReactiveCocoa for reactive bindings. The bridging header (`mm-Bridging-Header.h`) exposes Objective-C classes to Swift.

### Flutter ↔ Native Integration

The Flutter module is embedded in the native iOS app via CocoaPods (`install_all_flutter_pods(flutter_application_path)` in `mm/Podfile`). The native `AppDelegate`/`SceneDelegate` bootstraps the native UI, and the Flutter engine can be spun up as needed.
