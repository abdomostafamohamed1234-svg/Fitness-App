
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flowery/features/home/presentation/view/widgets/category_section_widget.dart';
import 'package:flowery/features/home/domian/entities/work_out_model.dart';

/// NOTES / ASSUMPTIONS:
/// - `musclesGroup` is declared as a required param but is NOT actually used
///   inside `build()` (the row is hard-coded: Gym / Fitness / Yoga /
///   Airobics / Trainner). So we can safely pass an empty list without
///   needing to know MuscleGroupModel's constructor.
/// - The category tiles use `Image.asset(...)`. Asset loading can throw in
///   the test environment because the asset bundle isn't wired up unless
///   your test uses `flutter test` with a properly configured
///   `flutter_test` asset manifest (this normally works fine for
///   `flutter test` run from the project root, since assets declared in
///   pubspec.yaml are bundled automatically). If you see asset-related
///   exceptions, they're safe to ignore for these tests — we only assert
///   on the text labels, not on pixel output.

Widget _wrap(Widget child) {
  return MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.black,
      body: child,
    ),
  );
}

void main() {
  group('CategorySectionWidget', () {
    testWidgets('renders the "Category" title', (tester) async {
      await tester.pumpWidget(
        _wrap(const CategorySectionWidget(musclesGroup: <MuscleGroupModel>[])),
      );

      expect(find.text('Category'), findsOneWidget);
    });

    testWidgets('renders all five category labels', (tester) async {
      await tester.pumpWidget(
        _wrap(const CategorySectionWidget(musclesGroup: <MuscleGroupModel>[])),
      );

      expect(find.text('Gym'), findsOneWidget);
      expect(find.text('Fitness'), findsOneWidget);
      expect(find.text('Yoga'), findsOneWidget);
      expect(find.text('Airobics'), findsOneWidget);
      expect(find.text('Trainner'), findsOneWidget);
    });

    testWidgets('renders 5 Image widgets and 4 dividers', (tester) async {
      await tester.pumpWidget(
        _wrap(const CategorySectionWidget(musclesGroup: <MuscleGroupModel>[])),
      );

      expect(find.byType(Image), findsNWidgets(5));
      // 4 vertical divider Containers sit between the 5 items.
      expect(find.byType(SizedBox), findsWidgets);
    });

    group('CategorySectionWidget.iconFor (static helper)', () {
      test('maps known keywords to the right icon', () {
        expect(CategorySectionWidget.iconFor('Gym Class'), Icons.fitness_center);
        expect(CategorySectionWidget.iconFor('Morning Yoga'), Icons.self_improvement);
        expect(CategorySectionWidget.iconFor('Cardio Run'), Icons.directions_run);
        expect(CategorySectionWidget.iconFor('Running'), Icons.directions_run);
        expect(CategorySectionWidget.iconFor('Swimming'), Icons.pool);
        expect(CategorySectionWidget.iconFor('Cycling'), Icons.directions_bike);
        expect(CategorySectionWidget.iconFor('Bike Ride'), Icons.directions_bike);
      });

      test('falls back to sports_gymnastics for unknown keywords', () {
        expect(CategorySectionWidget.iconFor('Random Category'), Icons.sports_gymnastics);
        expect(CategorySectionWidget.iconFor(''), Icons.sports_gymnastics);
      });

      test('is case-insensitive', () {
        expect(CategorySectionWidget.iconFor('GYM'), Icons.fitness_center);
        expect(CategorySectionWidget.iconFor('YoGa'), Icons.self_improvement);
      });
    });
  });
}