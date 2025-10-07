/** Copyright © 2025 Neothan
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *     http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'circular_image_button.dart';

void main() {
  group('CircularImageButton Tests', () {
    testWidgets('should render with correct size', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CircularImageButton(
              imagePath: 'test_image.png',
              size: 100.0,
              onTap: () {},
            ),
          ),
        ),
      );

      final button = find.byType(CircularImageButton);
      expect(button, findsOneWidget);

      final container = find.byType(Container);
      expect(container, findsOneWidget);
    });

    testWidgets('should handle tap events', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CircularImageButton(
              imagePath: 'test_image.png',
              size: 60.0,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(CircularImageButton));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('should show fallback icon when image fails to load', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CircularImageButton(
              imagePath: 'non_existent_image.png',
              size: 60.0,
              onTap: () {},
              fallbackIcon: Icons.error,
              fallbackIconColor: Colors.red,
            ),
          ),
        ),
      );

      await tester.pump();

      final icon = find.byIcon(Icons.error);
      expect(icon, findsOneWidget);
    });

    testWidgets('should animate on press', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CircularImageButton(
              imagePath: 'test_image.png',
              size: 60.0,
              onTap: () {},
              pressedScale: 0.8,
            ),
          ),
        ),
      );

      await tester.pump();

      await tester.tap(find.byType(CircularImageButton));
      await tester.pump(const Duration(milliseconds: 75));

      final transform = find.byType(Transform);
      expect(transform, findsOneWidget);

      await tester.pump(const Duration(milliseconds: 75));
    });
  });

  group('BorderedCircularImageButton Tests', () {
    testWidgets('should render with border', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BorderedCircularImageButton(
              imagePath: 'test_image.png',
              size: 60.0,
              onTap: () {},
              borderColor: Colors.blue,
              borderWidth: 2.0,
            ),
          ),
        ),
      );

      final button = find.byType(BorderedCircularImageButton);
      expect(button, findsOneWidget);
    });
  });

  group('GradientCircularImageButton Tests', () {
    testWidgets('should render with gradient', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GradientCircularImageButton(
              imagePath: 'test_image.png',
              size: 60.0,
              onTap: () {},
              gradientColors: [Colors.blue, Colors.purple],
              gradientDirection: GradientDirection.linear,
            ),
          ),
        ),
      );

      final button = find.byType(GradientCircularImageButton);
      expect(button, findsOneWidget);
    });
  });

  group('Rotation Tests', () {
    testWidgets('should rotate when enabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CircularImageButton(
              imagePath: 'test_image.png',
              size: 60.0,
              onTap: () {},
              enableRotation: true,
              rotationSpeed: 90.0,
            ),
          ),
        ),
      );

      await tester.pump();

      final transform = find.byType(Transform);
      expect(transform, findsOneWidget);

      await tester.pump(const Duration(milliseconds: 500));
    });

    testWidgets('should stop rotation on press when configured', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CircularImageButton(
              imagePath: 'test_image.png',
              size: 60.0,
              onTap: () {},
              enableRotation: true,
              rotationSpeed: 90.0,
              stopRotationOnPress: true,
            ),
          ),
        ),
      );

      await tester.pump();

      await tester.tap(find.byType(CircularImageButton));
      await tester.pump();

      final transform = find.byType(Transform);
      expect(transform, findsOneWidget);
    });
  });
}
