# Contributing to Growth Social AI App

Thank you for your interest in contributing to Growth Social AI App! We welcome contributions from the community and are grateful for your help in making this project better.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [How to Contribute](#how-to-contribute)
- [Development Setup](#development-setup)
- [Coding Standards](#coding-standards)
- [Pull Request Process](#pull-request-process)
- [Issue Reporting](#issue-reporting)
- [Community Guidelines](#community-guidelines)

## Code of Conduct

This project and everyone participating in it is governed by our [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code. Please report unacceptable behavior to [neothan7@hotmail.com](mailto:neothan7@hotmail.com).

## Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** (3.10.0 or higher)
- **Dart SDK** (latest stable)
- **Git** (for version control)
- **IDE** (VS Code, Android Studio, or IntelliJ IDEA)
- **Platform-specific tools** (Xcode for iOS, Android Studio for Android)

### Development Environment Setup

1. **Fork and Clone**
   ```bash
   # Fork the repository on GitHub
   git clone https://github.com/neothan-dev/growth-social-ai-app.git
   cd growth-social-ai-app
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the Application**
   ```bash
   flutter run
   ```

## How to Contribute

### Types of Contributions

We welcome several types of contributions:

- **Bug Fixes**: Fix issues and improve stability
- **Feature Development**: Add new features and functionality
- **Documentation**: Improve documentation and guides
- **Testing**: Add tests and improve test coverage
- **Performance**: Optimize code and improve performance
- **UI/UX**: Enhance user interface and experience
- **Internationalization**: Add new language support

### Contribution Workflow

1. **Check Existing Issues**
   - Look through [existing issues](https://github.com/your-username/vital-ai-app/issues)
   - Comment on issues you'd like to work on
   - Ask questions if you need clarification

2. **Create a Branch**
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/your-bug-fix
   ```

3. **Make Your Changes**
   - Write clean, well-documented code
   - Follow our coding standards
   - Add tests for new functionality
   - Update documentation as needed

4. **Test Your Changes**
   ```bash
   flutter test
   flutter analyze
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

## Development Setup

### Project Structure

```
lib/
├── config/           # Configuration files
├── models/           # Data models
├── screens/          # UI screens
├── services/         # Business logic services
├── widgets/          # Reusable UI components
├── theme/            # App theming
├── utils/            # Utility functions
└── localization/     # Internationalization
```

### Key Development Commands

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run

# Run tests
flutter test

# Analyze code
flutter analyze

# Format code
dart format .

# Build for different platforms
flutter build apk --release
flutter build ios --release
flutter build web --release
```

## Coding Standards

### Dart/Flutter Standards

- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable and function names
- Write comprehensive comments for complex logic
- Follow Flutter best practices
- Use proper widget composition

### Code Formatting

```bash
# Format all Dart files
dart format .

# Format specific files
dart format lib/screens/dashboard_screen.dart
```

### Naming Conventions

- **Files**: Use snake_case (e.g., `user_profile_screen.dart`)
- **Classes**: Use PascalCase (e.g., `UserProfileScreen`)
- **Variables**: Use camelCase (e.g., `userName`)
- **Constants**: Use SCREAMING_SNAKE_CASE (e.g., `API_BASE_URL`)

### Documentation

- Write clear, concise comments
- Document public APIs
- Include examples for complex functions
- Update README files when adding features

## Pull Request Process

### Before Submitting

- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] No breaking changes (or clearly documented)

### Pull Request Template

When creating a pull request, please include:

1. **Description**: What changes were made and why
2. **Type**: Bug fix, feature, documentation, etc.
3. **Testing**: How the changes were tested
4. **Screenshots**: For UI changes
5. **Breaking Changes**: Any breaking changes and migration steps

### Review Process

1. **Automated Checks**: CI/CD pipeline runs automatically
2. **Code Review**: Maintainers review the code
3. **Testing**: Changes are tested in different environments
4. **Approval**: At least one maintainer approval required
5. **Merge**: Changes are merged to main branch

## Issue Reporting

### Before Creating an Issue

1. **Search**: Check if the issue already exists
2. **Reproduce**: Ensure you can reproduce the issue
3. **Gather Info**: Collect relevant information

### Issue Template

When creating an issue, please include:

- **Description**: Clear description of the issue
- **Steps to Reproduce**: Detailed steps to reproduce
- **Expected Behavior**: What should happen
- **Actual Behavior**: What actually happens
- **Environment**: OS, Flutter version, device info
- **Screenshots**: If applicable
- **Additional Context**: Any other relevant information

### Issue Labels

- `bug`: Something isn't working
- `enhancement`: New feature or request
- `documentation`: Improvements to documentation
- `good first issue`: Good for newcomers
- `help wanted`: Extra attention is needed
- `question`: Further information is requested

## Community Guidelines

### Communication

- **Be Respectful**: Treat everyone with respect
- **Be Constructive**: Provide helpful feedback
- **Be Patient**: Remember that everyone is learning
- **Be Inclusive**: Welcome newcomers and diverse perspectives

### Getting Help

- **Documentation**: Check our [Wiki](https://github.com/neothan-dev/growth-social-ai-app/wiki)
- **Discussions**: Use [GitHub Discussions](https://github.com/neothan-dev/growth-social-ai-app/discussions)
- **Issues**: Create an issue for bugs or feature requests
- **Email**: Contact us at [neothan7@hotmail.com](mailto:neothan7@hotmail.com)

### Recognition

Contributors will be recognized in:
- **README**: Listed as contributors
- **Release Notes**: Mentioned in release announcements
- **Documentation**: Credited in relevant sections

## Development Resources

### Useful Links

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Flutter Widget Catalog](https://flutter.dev/docs/development/ui/widgets)
- [Material Design Guidelines](https://material.io/design)

### Tools and Extensions

- **VS Code Extensions**:
  - Flutter
  - Dart
  - Bracket Pair Colorizer
  - GitLens

- **Android Studio Plugins**:
  - Flutter
  - Dart

## Release Process

### Version Numbering

We follow [Semantic Versioning](https://semver.org/):
- **MAJOR**: Incompatible API changes
- **MINOR**: New functionality in a backwards compatible manner
- **PATCH**: Backwards compatible bug fixes

### Release Checklist

- [ ] All tests passing
- [ ] Documentation updated
- [ ] Version number updated
- [ ] Changelog updated
- [ ] Release notes prepared
- [ ] Build artifacts created

## Questions?

If you have any questions about contributing, please:

1. Check our [FAQ](https://github.com/neothan-dev/growth-social-ai-app/wiki/FAQ)
2. Join our [Discussions](https://github.com/neothan-dev/growth-social-ai-app/discussions)
3. Contact us at [neothan7@hotmail.com](mailto:neothan7@hotmail.com)

Thank you for contributing to Growth Social AI App! 🎉
