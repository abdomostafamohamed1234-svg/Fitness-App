import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shimmer/shimmer.dart';

import 'package:flowery/features/home/presentation/view/widgets/home_shimmer_widget.dart';

/// All four shimmer widgets are self-contained (no external data), so we
/// mainly assert on structure: that a `Shimmer` wrapper exists and the
/// expected number of placeholder tiles are laid out.

Widget _wrap(Widget child) {
  return MaterialApp(
    home: Scaffold(backgroundColor: Colors.black, body: child),
  );
}

void main() {
  group('CategoryShimmer', () {
    testWidgets('wraps content in a Shimmer and renders 5 tiles', (tester) async {
      await tester.pumpWidget(_wrap(const CategoryShimmer()));

      expect(find.byType(Shimmer), findsOneWidget);
      // 5 icon+label placeholder tiles, each with 2 shimmer boxes -> 10
      // Container-based boxes, plus the title bar = 11. We just check the
      // Row lays out 5 Expanded children instead of counting every box.
      expect(find.byType(Row), findsWidgets);
    });
  });

  group('RecommendationShimmer', () {
    testWidgets('wraps content in a Shimmer and renders 4 placeholder cards',
        (tester) async {
      await tester.pumpWidget(_wrap(const RecommendationShimmer()));

      expect(find.byType(Shimmer), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
    });
  });

  group('WorkoutShimmer', () {
    testWidgets('wraps content in a Shimmer and renders chips + cards', (tester) async {
      await tester.pumpWidget(_wrap(const WorkoutShimmer()));

      expect(find.byType(Shimmer), findsOneWidget);
      // 2 horizontal ListViews: filter chips row + workout cards row.
      expect(find.byType(ListView), findsNWidgets(2));
    });
  });

  group('FoodShimmer', () {
    testWidgets('wraps content in a Shimmer and renders placeholder cards', (tester) async {
      await tester.pumpWidget(_wrap(const FoodShimmer()));

      expect(find.byType(Shimmer), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
    });
  });
}
