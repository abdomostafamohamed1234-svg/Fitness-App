// test/features/app_sections/presentation/view/widgets/custom_nav_bar_test.dart
//
// دي محتاجة الـ real AppLocalizations عشان CustomNavBar بتعمل
// AppLocalizations.of(context)! جوه الـ build، فبنلف الـ widget بـ MaterialApp
// حقيقي معاه localizationsDelegates.

import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/features/app_sections/domain/entities/custom_nav_item_model.dart';
import 'package:flowery/features/app_sections/presentation/view/widgets/custom_nav_bar.dart';
import 'package:flowery/features/app_sections/presentation/view/widgets/custom_nav_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockIntCallback extends Mock {
  void call(int index);
}

void main() {
  late MockIntCallback mockOnTap;

  final testItems = [
    CustomNavItemModel(getLabel: (_) => 'Explore', icon: 'assets/icons/home.svg'),
    CustomNavItemModel(getLabel: (_) => 'Chat', icon: 'assets/icons/chat.svg'),
    CustomNavItemModel(
      getLabel: (_) => 'Workouts',
      icon: 'assets/icons/workout.svg',
    ),
    CustomNavItemModel(
      getLabel: (_) => 'Profile',
      icon: 'assets/icons/profile.svg',
    ),
  ];

  setUp(() {
    mockOnTap = MockIntCallback();
  });

  Widget buildTestable({required int currentIndex}) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: CustomNavBar(
          items: testItems,
          currentIndex: currentIndex,
          onTap: mockOnTap.call,
        ),
      ),
    );
  }

  group('CustomNavBar', () {
    testWidgets('بيعرض عدد عناصر يساوي طول الـ items list', (tester) async {
      await tester.pumpWidget(buildTestable(currentIndex: 0));
      await tester.pumpAndSettle();

      expect(find.byType(CustomNavBarItem), findsNWidgets(testItems.length));
    });

    testWidgets('العنصر المتوافق مع currentIndex هو الوحيد الظاهر عنوانه', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestable(currentIndex: 1));
      await tester.pumpAndSettle();

      expect(find.text('Chat'), findsOneWidget);
      expect(find.text('Explore'), findsNothing);
      expect(find.text('Workouts'), findsNothing);
      expect(find.text('Profile'), findsNothing);
    });



    testWidgets('تغيير currentIndex بيغيّر مين العنصر اللي isSelected = true', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestable(currentIndex: 0));
      await tester.pumpAndSettle();

      var items = tester.widgetList<CustomNavBarItem>(
        find.byType(CustomNavBarItem),
      );
      expect(items.elementAt(0).isSelected, isTrue);
      expect(items.elementAt(1).isSelected, isFalse);

      await tester.pumpWidget(buildTestable(currentIndex: 3));
      await tester.pumpAndSettle();

      items = tester.widgetList<CustomNavBarItem>(
        find.byType(CustomNavBarItem),
      );
      expect(items.elementAt(0).isSelected, isFalse);
      expect(items.elementAt(3).isSelected, isTrue);
    });
  });
}