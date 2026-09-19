import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flowery/features/home/presentation/view/widgets/recommendation_section_widget.dart';
import 'package:flowery/features/home/domian/entities/recommendation_model.dart';

/// ASSUMPTION: `MuscleModel` isn't available to me. Built from the fields
/// actually used in the widget: `muscle.name` (String) and
/// `muscle.image` (String?, nullable). Adjust `_muscle(...)` if your real
/// model differs.
MuscleModel _muscle({required String name, String? image}) {
  return MuscleModel(name: name, image: image, id: '1');
}

Widget _wrap(Widget child) {
  return MaterialApp(
    home: Scaffold(backgroundColor: Colors.black, body: child),
  );
}

void main() {
  group('RecommendationSectionWidget', () {
    testWidgets('renders the section title', (tester) async {
      await tester.pumpWidget(_wrap(const RecommendationSectionWidget(muscles: [])));

      expect(find.text('Recommendation To Day'), findsOneWidget);
    });

    testWidgets('renders one card per muscle with its name', (tester) async {
      final muscles = [
        _muscle(name: 'Chest', image: 'https://example.com/chest.png'),
        _muscle(name: 'Back', image: 'https://example.com/back.png'),
      ];

      await tester.pumpWidget(_wrap(RecommendationSectionWidget(muscles: muscles)));

      expect(find.text('Chest'), findsOneWidget);
      expect(find.text('Back'), findsOneWidget);
      expect(find.byType(GestureDetector), findsNWidgets(2));
    });

    testWidgets('shows a fallback fitness icon when image is null', (tester) async {
      final muscles = [_muscle(name: 'Legs', image: null)];

      await tester.pumpWidget(_wrap(RecommendationSectionWidget(muscles: muscles)));

      expect(find.text('Legs'), findsOneWidget);
      expect(find.byIcon(Icons.fitness_center), findsOneWidget);
      // No dark overlay Container is added when there's no image to darken.
      expect(find.byType(Image), findsNothing);
    });

    testWidgets('renders nothing when muscles list is empty', (tester) async {
      await tester.pumpWidget(_wrap(const RecommendationSectionWidget(muscles: [])));

      expect(find.byType(GestureDetector), findsNothing);
    });
  });
}