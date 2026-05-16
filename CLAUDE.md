# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run

# Run all tests
flutter test

# Run a single test file
flutter test test/src/features/notes/data/notes_repository_test.dart

# Lint/analyze
dart analyze

# Regenerate Riverpod providers after modifying @riverpod annotations
flutter pub run build_runner build --delete-conflicting-outputs
```

## Architecture

This is a Flutter app (Noteworthy) using a **feature-first, clean architecture** pattern with Riverpod for state management and Firebase as the backend.

### Folder structure

```
lib/
├── features/
│   ├── authentication/     # Sign in/up, Firebase Auth integration
│   │   ├── data/           # AuthRepository
│   │   ├── domain/         # AppUser model
│   │   └── presentation/   # Screens + controllers
│   └── notes/              # CRUD for notes
│       ├── data/           # NotesRepository (Firestore)
│       ├── domain/         # Note model
│       └── presentation/   # Screens + controllers
├── routing/                # GoRouter config and AppRoute enum
├── common_widgets/         # Shared UI components
├── constants/              # Colors, sizes, breakpoints
├── exceptions/             # AppException sealed class
└── utils/                  # AsyncValue extensions, NotifierMounted mixin
```

### State management (Riverpod)

- All providers use `@riverpod` annotations with code generation (`.g.dart` files)
- **Repositories** are `keepAlive: true` singleton providers — direct Firebase wrappers
- **Controllers** are `AsyncNotifier` subclasses — handle business logic and call repositories
- Screens watch providers for data and delegate actions to controllers
- After modifying any `@riverpod` class or function, run `build_runner` to regenerate

### Navigation (GoRouter)

Routes are defined in `lib/routing/` via the `AppRoute` enum: `home`, `signIn`, `signUp`, `profile`, `addNote`, `editNote`. Auth redirects are handled via a `refreshListenable` on the auth state stream — unauthenticated users go to sign-up, authenticated users go to home.

### Data layer

- **Firestore** uses `withConverter` for type-safe document handling; all notes are scoped by uid
- **Domain models** (`Note`, `AppUser`) implement `Equatable`, have `copyWith`, `fromMap`/`toMap`
- Stream-based providers (real-time) use `watch*` naming; future-based use `fetch*`

### Error handling

- `AppException` is a sealed class — catch Firebase exceptions and map them here
- `AsyncValueUI` extension on `AsyncValue` shows error dialogs from the UI layer
- `NotifierMounted` mixin prevents state updates after controller disposal

### UI conventions

- Material 3 with Poppins font
- `AsyncValueWidget` wraps loading/error/data states
- `ResponsiveCenter` / `ResponsiveTwoColumnLayout` for multi-platform layout
- Strings marked with `// @StringHardcoded` for future localization
