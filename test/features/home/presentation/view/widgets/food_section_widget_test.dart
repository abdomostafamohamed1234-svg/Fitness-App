import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flowery/features/home/presentation/view/widgets/food_section_widget.dart';
import 'package:flowery/features/home/domian/entities/food_for_you_model.dart';

/// ASSUMPTION: `CategoryModel` is not available to me, so this test builds
/// it from the fields actually used inside `FoodSectionWidget`:
/// `category.imageUrl` (String) and `category.name` (String).
///
/// If your real `CategoryModel` requires more/other named params, adjust
/// the `_category(...)` helper below accordingly — the rest of the test
/// file doesn't need to change.
CategoryModel _category({required String name, required String imageUrl}) {
  return CategoryModel(name: name, imageUrl: imageUrl);
}

Widget _wrap(Widget child) {
  return MaterialApp(
    // FoodSectionWidget's "See All" button calls context.pushNamed(AppRoutes.food)
    // via a routing extension. We don't know if that's go_router or plain
    // Navigator based, so we only verify the button renders — we don't tap it
    // here to avoid a false failure from an unconfigured router.
    home: Scaffold(backgroundColor: Colors.black, body: child),
  );
}

void main() {
  group('FoodSectionWidget', () {
    testWidgets('renders the section title and "See All" button', (tester) async {
      await tester.pumpWidget(_wrap(const FoodSectionWidget(categories: [])));

      expect(find.text('Recommendation For You'), findsOneWidget);
      expect(find.text('See All'), findsOneWidget);
    });

    testWidgets('renders one card per category with its name', (tester) async {
      final categories = [
        _category(name: 'Breakfast', imageUrl: 'https://example.com/a.png'),
        _category(name: 'Lunch', imageUrl: 'https://example.com/b.png'),
        _category(name: 'Dinner', imageUrl: 'https://example.com/c.png'),
      ];

      await tester.pumpWidget(_wrap(FoodSectionWidget(categories: categories)));

      expect(find.text('Breakfast'), findsOneWidget);
      expect(find.text('Lunch'), findsOneWidget);
      expect(find.text('Dinner'), findsOneWidget);
      expect(find.byType(GestureDetector), findsNWidgets(3));
    });

    testWidgets('renders nothing in the list when categories is empty', (tester) async {
      await tester.pumpWidget(_wrap(const FoodSectionWidget(categories: [])));

      expect(find.byType(GestureDetector), findsNothing);
    });

    testWidgets('falls back to a restaurant icon when the image fails to load',
        (tester) async {
      final categories = [
        _category(name: 'Broken Image', imageUrl: 'https://not-a-real-domain.invalid/x.png'),
      ];

      await tester.pumpWidget(_wrap(FoodSectionWidget(categories: categories)));
      // Let the failed network image settle and trigger errorBuilder.
      await tester.pump(const Duration(seconds: 1));

      expect(find.byIcon(Icons.restaurant), findsOneWidget);
    });
  });
}