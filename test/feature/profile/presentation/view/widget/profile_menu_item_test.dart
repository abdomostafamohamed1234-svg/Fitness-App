import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flowery/feature/profile/presentation/view/widget/profile_menu_item.dart';

void main() {
  /// Wraps widget in a MaterialApp with a fixed screen size (800x600) so that
  /// all items are guaranteed to be visible and tappable.
  Widget wrap(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: 800,
          height: 600,
          child: SingleChildScrollView(child: child),
        ),
      ),
    );
  }

  /// Finds the first RichText that is a descendant of [ProfileMenuItem].
  /// This avoids accidentally picking up RichText nodes created by MaterialApp
  /// or Scaffold themselves.
  RichText _findMenuRichText(WidgetTester tester) {
    final menuItemElement = tester.element(find.byType(ProfileMenuItem));
    final richTexts = tester
        .widgetList<RichText>(
          find.descendant(
            of: find.byType(ProfileMenuItem),
            matching: find.byType(RichText),
          ),
        )
        .toList();
    // The first RichText inside ProfileMenuItem is always the title span
    return richTexts.first;
  }

  testWidgets('يعرض العنوان والأيقونة وسهم الانتقال الافتراضي', (tester) async {
    await tester.pumpWidget(
      wrap(
        const ProfileMenuItem(icon: Icons.person_outline, title: 'Edit Profile'),
      ),
    );

    expect(find.text('Edit Profile', findRichText: true), findsOneWidget);
    expect(find.byIcon(Icons.person_outline), findsOneWidget);
    expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    expect(find.byType(Switch), findsNothing);
  });

  testWidgets('يعرض trailingText جنب العنوان لما يتبعت', (tester) async {
    await tester.pumpWidget(
      wrap(
        const ProfileMenuItem(
          icon: Icons.language,
          title: 'Select Language',
          trailingText: 'English',
        ),
      ),
    );

    final richText = _findMenuRichText(tester);
    final textSpan = richText.text as TextSpan;
    final fullText = textSpan.toPlainText();
    expect(fullText, 'Select Language (English)');
  });

  testWidgets('يعرض Switch بدل السهم لما showSwitch = true وبيرجع القيمة الصح', (
    tester,
  ) async {
    bool? switchValueReceived;

    await tester.pumpWidget(
      wrap(
        ProfileMenuItem(
          icon: Icons.language,
          title: 'Select Language',
          showSwitch: true,
          switchValue: true,
          onSwitchChanged: (value) => switchValueReceived = value,
        ),
      ),
    );

    expect(find.byType(Switch), findsOneWidget);
    expect(find.byIcon(Icons.chevron_right), findsNothing);

    final switchWidget = tester.widget<Switch>(find.byType(Switch));
    expect(switchWidget.value, isTrue);

    await tester.tap(find.byType(Switch));
    await tester.pump();

    expect(switchValueReceived, isFalse);
  });

  testWidgets('يستخدم لون الـ accent للعنوان لما isDestructive = true', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrap(
        const ProfileMenuItem(
          icon: Icons.logout,
          title: 'Logout',
          isDestructive: true,
        ),
      ),
    );

    final richText = _findMenuRichText(tester);
    final textSpan = richText.text as TextSpan;
    expect(textSpan.style?.color, const Color(0xFFFF5A36));
  });

  testWidgets('اللون الافتراضي للعنوان أبيض لما isDestructive = false', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrap(
        const ProfileMenuItem(icon: Icons.lock_reset, title: 'Change Password'),
      ),
    );

    final richText = _findMenuRichText(tester);
    final textSpan = richText.text as TextSpan;
    expect(textSpan.style?.color, Colors.white);
  });

  testWidgets('لازم يستدعي onTap لما المستخدم يدوس على العنصر', (tester) async {
    var tapped = false;

    await tester.pumpWidget(
      wrap(
        ProfileMenuItem(
          icon: Icons.settings_outlined,
          title: 'Security',
          onTap: () => tapped = true,
        ),
      ),
    );

    await tester.tap(find.text('Security', findRichText: true));
    await tester.pump();

    expect(tapped, isTrue);
  });
}