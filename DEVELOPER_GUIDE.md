# Growth Social AI App Developer Guide

This guide is for developers who want to contribute to Growth Social AI App or integrate with our platform.

## Table of Contents

1. [Getting Started](#getting-started)
2. [Development Environment](#development-environment)
3. [Project Structure](#project-structure)
4. [Coding Standards](#coding-standards)
5. [Testing](#testing)
6. [Contributing](#contributing)
7. [API Integration](#api-integration)
8. [Deployment](#deployment)
9. [Troubleshooting](#troubleshooting)

## Getting Started

### Prerequisites

- **Flutter SDK**: 3.10.0 or higher
- **Dart SDK**: 3.0.0 or higher
- **IDE**: VS Code, Android Studio, or IntelliJ IDEA
- **Git**: For version control
- **Platform-specific tools**:
  - **Android**: Android Studio, Android SDK
  - **iOS**: Xcode, iOS SDK
  - **Web**: Chrome, Firefox, Safari
  - **Desktop**: Platform-specific development tools

### Installation

1. **Clone the Repository**
   ```bash
   git clone https://github.com/your-username/vital-ai-app.git
   cd vital-ai-app
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the Application**
   ```bash
   flutter run
   ```

### First-Time Setup

1. **Configure Environment**
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

2. **Set Up API Keys**
   - Get API keys from [Growth Social AI App Developer Portal](https://developers.growthsocialaiapp.app)
   - Add keys to your environment configuration

3. **Configure Platform-Specific Settings**
   - **Android**: Update `android/app/build.gradle`
   - **iOS**: Update `ios/Runner/Info.plist`
   - **Web**: Update `web/index.html`

## Development Environment

### IDE Setup

#### VS Code (Recommended)

**Required Extensions:**
- Flutter
- Dart
- Bracket Pair Colorizer
- GitLens
- Error Lens
- Flutter Widget Snippets

**Settings:**
```json
{
  "dart.flutterSdkPath": "/path/to/flutter",
  "dart.lineLength": 80,
  "editor.formatOnSave": true,
  "editor.rulers": [80],
  "dart.previewFlutterUiGuides": true
}
```

#### Android Studio

**Required Plugins:**
- Flutter
- Dart
- Git Integration
- Database Navigator
- JSON Viewer

**Settings:**
- Enable Flutter plugin
- Configure Dart SDK path
- Set up Flutter SDK path

### Development Tools

#### Code Quality Tools
- **Dart Analyzer**: Built-in static analysis
- **Flutter Lints**: Additional linting rules
- **Dart Format**: Code formatting
- **Dart Test**: Unit testing framework

#### Debugging Tools
- **Flutter Inspector**: Widget tree inspection
- **Dart DevTools**: Performance profiling
- **VS Code Debugger**: Step-by-step debugging
- **Flutter Logs**: Console logging

## Project Structure

### Directory Layout

```
lib/
├── config/                 # Configuration files
│   ├── network_config.dart
│   └── voice_config.dart
├── models/                 # Data models
│   ├── user.dart
│   ├── health_data.dart
│   └── message.dart
├── screens/                # UI screens
│   ├── dashboard/
│   ├── health/
│   ├── chat/
│   └── social/
├── services/               # Business logic
│   ├── ai_service.dart
│   ├── health_service.dart
│   └── auth_service.dart
├── widgets/                # Reusable components
│   ├── health_card.dart
│   ├── chat_bubble.dart
│   └── social_post.dart
├── theme/                  # App theming
│   ├── app_theme.dart
│   └── colors.dart
├── utils/                  # Utility functions
│   ├── date_utils.dart
│   └── validation_utils.dart
└── localization/           # Internationalization
    ├── app_localizations.dart
    └── languages/
```

### Key Components

#### Models
- **User**: User profile and authentication data
- **HealthData**: Health metrics and measurements
- **Message**: Chat and communication data
- **Friend**: Social connections and relationships

#### Services
- **AIService**: AI assistant and chat functionality
- **HealthService**: Health data management
- **AuthService**: User authentication and authorization
- **SocialService**: Social features and community

#### Screens
- **Dashboard**: Main health overview
- **Health**: Health tracking and analytics
- **Chat**: AI assistant interface
- **Social**: Community and friends

## Coding Standards

### Dart/Flutter Standards

#### Code Style
- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable and function names
- Write comprehensive comments for complex logic
- Follow Flutter best practices and patterns

#### Naming Conventions
- **Files**: Use snake_case (e.g., `user_profile_screen.dart`)
- **Classes**: Use PascalCase (e.g., `UserProfileScreen`)
- **Variables**: Use camelCase (e.g., `userName`)
- **Constants**: Use SCREAMING_SNAKE_CASE (e.g., `API_BASE_URL`)

#### Code Organization
```dart
// 1. Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 2. Class declaration
class UserProfileScreen extends StatefulWidget {
  // 3. Constructor
  const UserProfileScreen({Key? key}) : super(key: key);

  // 4. State class
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  // 5. Fields
  late User _user;
  bool _isLoading = false;

  // 6. Lifecycle methods
  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  // 7. Build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Widget implementation
    );
  }

  // 8. Helper methods
  void _loadUser() {
    // Implementation
  }
}
```

### Documentation Standards

#### Code Comments
```dart
/// A service class for managing user authentication.
/// 
/// This class handles user login, logout, and session management.
/// It provides methods for authenticating users and managing their
/// authentication state throughout the application.
class AuthService {
  /// Authenticates a user with the provided credentials.
  /// 
  /// Returns a [User] object if authentication is successful,
  /// or throws an [AuthException] if authentication fails.
  /// 
  /// Example:
  /// ```dart
  /// final user = await authService.login('user@example.com', 'password');
  /// ```
  Future<User> login(String email, String password) async {
    // Implementation
  }
}
```

#### API Documentation
- Document all public methods and classes
- Include parameter descriptions and return types
- Provide usage examples
- Document error conditions and exceptions

## Testing

### Testing Strategy

#### Unit Tests
- Test individual functions and methods
- Mock external dependencies
- Test edge cases and error conditions
- Aim for high code coverage

#### Widget Tests
- Test UI components in isolation
- Test user interactions and gestures
- Test different states and configurations
- Test accessibility features

#### Integration Tests
- Test complete user workflows
- Test API integrations
- Test cross-platform functionality
- Test performance and reliability

### Writing Tests

#### Unit Test Example
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:growthsocialaiapp/services/health_service.dart';

void main() {
  group('HealthService', () {
    late HealthService healthService;

    setUp(() {
      healthService = HealthService();
    });

    test('should add health metric successfully', () async {
      // Arrange
      final metric = HealthMetric(
        type: 'weight',
        value: 70.5,
        unit: 'kg',
        timestamp: DateTime.now(),
      );

      // Act
      final result = await healthService.addMetric(metric);

      // Assert
      expect(result, isTrue);
    });

    test('should throw exception for invalid metric', () async {
      // Arrange
      final invalidMetric = HealthMetric(
        type: 'weight',
        value: -1, // Invalid value
        unit: 'kg',
        timestamp: DateTime.now(),
      );

      // Act & Assert
      expect(
        () => healthService.addMetric(invalidMetric),
        throwsA(isA<ValidationException>()),
      );
    });
  });
}
```

#### Widget Test Example
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growthsocialaiapp/widgets/health_card.dart';

void main() {
  group('HealthCard', () {
    testWidgets('should display health metric correctly', (WidgetTester tester) async {
      // Arrange
      final metric = HealthMetric(
        type: 'weight',
        value: 70.5,
        unit: 'kg',
        timestamp: DateTime.now(),
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: HealthCard(metric: metric),
        ),
      );

      // Assert
      expect(find.text('Weight'), findsOneWidget);
      expect(find.text('70.5 kg'), findsOneWidget);
    });

    testWidgets('should handle tap events', (WidgetTester tester) async {
      // Arrange
      final metric = HealthMetric(
        type: 'weight',
        value: 70.5,
        unit: 'kg',
        timestamp: DateTime.now(),
      );

      bool tapped = false;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: HealthCard(
            metric: metric,
            onTap: () => tapped = true,
          ),
        ),
      );

      await tester.tap(find.byType(HealthCard));
      await tester.pump();

      // Assert
      expect(tapped, isTrue);
    });
  });
}
```

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/services/health_service_test.dart

# Run tests with coverage
flutter test --coverage

# Run integration tests
flutter test integration_test/
```

## Contributing

### Development Workflow

1. **Fork the Repository**
   ```bash
   git fork https://github.com/your-username/vital-ai-app.git
   ```

2. **Create a Feature Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make Your Changes**
   - Write clean, well-documented code
   - Add tests for new functionality
   - Update documentation as needed

4. **Test Your Changes**
   ```bash
   flutter test
   flutter analyze
   dart format .
   ```

5. **Commit Your Changes**
   ```bash
   git add .
   git commit -m "Add: brief description of your changes"
   ```

6. **Push and Create Pull Request**
   ```bash
   git push origin feature/your-feature-name
   ```

### Pull Request Guidelines

#### Before Submitting
- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] No breaking changes (or clearly documented)

#### Pull Request Template
- **Description**: What changes were made and why
- **Type**: Bug fix, feature, documentation, etc.
- **Testing**: How the changes were tested
- **Screenshots**: For UI changes
- **Breaking Changes**: Any breaking changes and migration steps

### Code Review Process

1. **Automated Checks**: CI/CD pipeline runs automatically
2. **Code Review**: Maintainers review the code
3. **Testing**: Changes are tested in different environments
4. **Approval**: At least one maintainer approval required
5. **Merge**: Changes are merged to main branch

## API Integration

### REST API

#### Authentication
```dart
class ApiClient {
  static const String baseUrl = 'https://api.growthsocialaiapp.app/v1';
  static const String apiKey = 'your_api_key';

  static Map<String, String> get headers => {
    'Authorization': 'Bearer $apiKey',
    'Content-Type': 'application/json',
  };
}
```

#### Making Requests
```dart
class HealthService {
  Future<List<HealthMetric>> getMetrics() async {
    final response = await http.get(
      Uri.parse('${ApiClient.baseUrl}/health/metrics'),
      headers: ApiClient.headers,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['data']['metrics'] as List)
          .map((json) => HealthMetric.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load metrics');
    }
  }
}
```

#### Error Handling
```dart
class ApiException implements Exception {
  final String message;
  final int statusCode;

  ApiException(this.message, this.statusCode);

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}

Future<T> handleApiResponse<T>(http.Response response, T Function(Map<String, dynamic>) fromJson) async {
  if (response.statusCode >= 200 && response.statusCode < 300) {
    final data = json.decode(response.body);
    return fromJson(data['data']);
  } else {
    throw ApiException(
      'Request failed with status ${response.statusCode}',
      response.statusCode,
    );
  }
}
```

### WebSocket Integration

```dart
class WebSocketService {
  late WebSocketChannel _channel;
  StreamController<Map<String, dynamic>> _messageController = StreamController.broadcast();

  void connect() {
    _channel = WebSocketChannel.connect(
      Uri.parse('wss://api.growthsocialaiapp.app/ws'),
    );

    _channel.stream.listen((data) {
      final message = json.decode(data);
      _messageController.add(message);
    });
  }

  void sendMessage(Map<String, dynamic> message) {
    _channel.sink.add(json.encode(message));
  }

  Stream<Map<String, dynamic>> get messageStream => _messageController.stream;
}
```

## Deployment

### Build Configuration

#### Android
```bash
# Debug build
flutter build apk --debug

# Release build
flutter build apk --release

# App bundle for Play Store
flutter build appbundle --release
```

#### iOS
```bash
# Debug build
flutter build ios --debug

# Release build
flutter build ios --release

# Archive for App Store
flutter build ios --release --no-codesign
```

#### Web
```bash
# Debug build
flutter build web --debug

# Release build
flutter build web --release
```

#### Desktop
```bash
# Windows
flutter build windows --release

# macOS
flutter build macos --release

# Linux
flutter build linux --release
```

### Environment Configuration

#### Development
```dart
class Environment {
  static const String apiUrl = 'https://dev-api.growthsocialaiapp.app';
  static const String apiKey = 'dev_api_key';
  static const bool debugMode = true;
}
```

#### Production
```dart
class Environment {
  static const String apiUrl = 'https://api.growthsocialaiapp.app';
  static const String apiKey = 'prod_api_key';
  static const bool debugMode = false;
}
```

### CI/CD Pipeline

#### GitHub Actions
```yaml
name: CI/CD

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - uses: subosito/flutter-action@v2
    - run: flutter pub get
    - run: flutter test
    - run: flutter analyze

  build:
    runs-on: ubuntu-latest
    needs: test
    steps:
    - uses: actions/checkout@v3
    - uses: subosito/flutter-action@v2
    - run: flutter build apk --release
    - uses: actions/upload-artifact@v3
      with:
        name: app-release
        path: build/app/outputs/flutter-apk/
```

## Troubleshooting

### Common Issues

#### Build Issues
- **Flutter Version**: Ensure you're using the correct Flutter version
- **Dependencies**: Run `flutter pub get` to update dependencies
- **Clean Build**: Run `flutter clean` and rebuild
- **Platform Tools**: Ensure platform-specific tools are installed

#### Runtime Issues
- **Permissions**: Check app permissions on device
- **Network**: Ensure network connectivity
- **Storage**: Check available storage space
- **Memory**: Monitor memory usage

#### Development Issues
- **Hot Reload**: Restart the app if hot reload isn't working
- **Debugging**: Use Flutter Inspector for widget debugging
- **Performance**: Use Dart DevTools for performance profiling
- **Logs**: Check console logs for error messages

### Getting Help

#### Documentation
- **Flutter Docs**: [flutter.dev](https://flutter.dev)
- **Dart Docs**: [dart.dev](https://dart.dev)
- **Growth Social AI App Docs**: [docs.growthsocialaiapp.app](https://docs.growthsocialaiapp.app)

#### Community
- **GitHub Issues**: [github.com/your-username/vital-ai-app/issues](https://github.com/your-username/vital-ai-app/issues)
- **Discord**: [discord.gg/growthsocialaiapp](https://discord.gg/growthsocialaiapp)
- **Stack Overflow**: Tag questions with `growthsocialaiapp` and `flutter`

#### Support
- **Email**: [neothan7@hotmail.com](mailto:neothan7@hotmail.com)
- **GitHub Discussions**: [github.com/your-username/vital-ai-app/discussions](https://github.com/your-username/vital-ai-app/discussions)

---

*This developer guide is regularly updated. For the latest version, visit our documentation website.*

**Need help? Contact us at [neothan7@hotmail.com](mailto:neothan7@hotmail.com)**
