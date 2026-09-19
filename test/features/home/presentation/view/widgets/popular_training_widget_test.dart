import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flowery/features/home/presentation/view/widgets/popular_training_widget.dart';

/// This widget is fully self-contained (its 4 items are hard-coded static
/// data), so this is the most reliable test in the set — no mocking or
/// model assumptions needed.

Widget _wrap(Widget child) {
  return MaterialApp(
    home: Scaffold(backgroundColor: Colors.black, body: child),
  );
}

void main() {
  group('PopularTrainingSectionWidget', () {
    testWidgets('renders the section title and "See All" button', (tester) async {
      await tester.pumpWidget(_wrap(const PopularTrainingSectionWidget()));

      expect(find.text('Popular Training'), findsOneWidget);
      expect(find.text('See All'), findsOneWidget);
    });

    testWidgets('renders all 4 hard-coded training cards', (tester) async {
      await tester.pumpWidget(_wrap(const PopularTrainingSectionWidget()));

      expect(find.textContaining('Strengthen Your Chest'), findsOneWidget);
      expect(find.textContaining('Strengthen Your Back'), findsOneWidget);
      expect(find.textContaining('Full Body'), findsOneWidget);
      expect(find.textContaining('Core & Abs'), findsOneWidget);
    });

    testWidgets('renders task counts and level badges for each card', (tester) async {
      await tester.pumpWidget(_wrap(const PopularTrainingSectionWidget()));

      expect(find.text('24 Tasks'), findsOneWidget);
      expect(find.text('36 Tasks'), findsOneWidget);
      expect(find.text('18 Tasks'), findsOneWidget);
      expect(find.text('20 Tasks'), findsOneWidget);

      // "Beginner" appears twice (chest card + core card).
      expect(find.text('Beginner'), findsNWidgets(2));
      expect(find.text('Interm.'), findsOneWidget);
      expect(find.text('Advanced'), findsOneWidget);
    });

    testWidgets('"See All" button is tappable without throwing', (tester) async {
      await tester.pumpWidget(_wrap(const PopularTrainingSectionWidget()));

      await tester.tap(find.text('See All'));
      await tester.pump();

      // onPressed is currently a no-op (commented out navigation), so we
      // just assert the tap didn't crash the widget tree.
      expect(find.text('Popular Training'), findsOneWidget);
    });
  });
}