import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/app_sections/presentation/view/widgets/custom_nav_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockVoidCallback extends Mock {
  void call();
}

void main() {
  late MockVoidCallback mockOnTap;

  setUp(() {
    mockOnTap = MockVoidCallback();
  });

  Widget buildTestable({
    required bool isSelected,
    String title = 'Home',
    String icon = 'assets/icons/home.svg',
  }) {
    return MaterialApp(
      home: Scaffold(
        body: CustomNavBarItem(
          title: title,
          icon: icon,
          isSelected: isSelected,
          onTap: mockOnTap.call,
        ),
      ),
    );
  }

  group('CustomNavBarItem', () {
    testWidgets('لما يكون غير محدد (unselected) العنوان مش ظاهر', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestable(isSelected: false));
      await tester.pump();

      expect(find.text('Home'), findsNothing);
      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('لما يكون محدد (selected) العنوان بيظهر', (tester) async {
      await tester.pumpWidget(buildTestable(isSelected: true));
      // AnimatedSize / AnimatedSlide محتاجين نخلص الأنيميشن
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('بيستخدم اللون الأساسي (primaryColor) لما يكون selected', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestable(isSelected: true));
      await tester.pumpAndSettle();

      final svg = tester.widget<SvgPicture>(find.byType(SvgPicture));
      final colorFilter = svg.colorFilter as ColorFilter;
      expect(
        colorFilter,
        const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
      );
    });

    testWidgets('بيستخدم اللون الأبيض (whiteColor) لما يكون unselected', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestable(isSelected: false));
      await tester.pump();

      final svg = tester.widget<SvgPicture>(find.byType(SvgPicture));
      final colorFilter = svg.colorFilter as ColorFilter;
      expect(
        colorFilter,
        const ColorFilter.mode(AppColors.whiteColor, BlendMode.srcIn),
      );
    });

   }
  );
}