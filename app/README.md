# GameHunter Desktop App

The frontend application for **GameHunter**, built with **Flutter**.

## Architecture

This app uses a scalable, feature-first architecture with Riverpod for state management.

- **`lib/screens`**: UI pages (Home, Search, Details).
- **`lib/providers`**: State management logic (Riverpod).
- **`lib/models`**: Data models (GameRecord, SearchQuery).
- **`lib/services`**: External integrations (ProcessService regarding Engine).
- **`lib/widgets`**: Reusable UI components.

## Development

### Prerequisites

- Flutter SDK (stable channel)
- Desktop development tools (Visual Studio for Windows, Xcode for macOS, Ninja/GTK for Linux)

### Running Locally

1. **Install dependencies**:

   ```bash
   flutter pub get
   ```

2. **Run the app**:

   ```bash
   flutter run -d windows  # or macos, linux
   ```

   _Note: This requires the Python engine to be running separately if not using the bundled build._

### Building for Production

To build the release executable:

```bash
flutter build windows
# or
flutter build macos
# or
flutter build linux
```

## Configuration

- **App Name**: GameHunter
- **Bundle ID**: `com.ismail.gamehunter`
- **Engine Connection**: The app attempts to connect to the local Python engine on `localhost:8000` (configurable).

## Key dependencies

- `flutter_riverpod`: State management
- `go_router`: Navigation
- `dio`: Networking
- `cached_network_image`: Image caching
- `win32`: Windows API integration (if applicable)
