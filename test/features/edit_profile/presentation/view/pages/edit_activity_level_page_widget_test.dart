import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_theme.dart';
import 'package:flowery/features/edit_profile/presentation/view/pages/edit_activity_level_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpActivityPage(WidgetTester tester, {String? initialLevel}) {
    return tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
          theme: AppTheme.darkTheme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: EditActivityLevelPage(initialLevel: initialLevel),
        ),
      ),
    );
  }

  testWidgets('shows human-readable labels, not the raw level codes', (tester) async {
    await pumpActivityPage(tester, initialLevel: 'level1');

    expect(find.text('Rookie'), findsOneWidget);
    expect(find.text('Beginner'), findsOneWidget);
    expect(find.text('True Beast'), findsOneWidget);
    expect(find.text('level1'), findsNothing);
  });

  testWidgets('pops with the level code (e.g. level3), not the label', (tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
          theme: AppTheme.darkTheme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final result = await Navigator.of(context).push<String>(
                      MaterialPageRoute(builder: (_) => const EditActivityLevelPage()),
                    );
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('result:$result')));
                  },
                  child: const Text('open'),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Intermediate'));
    await tester.pump();

    final doneFinder = find.widgetWithText(ElevatedButton, 'Done');
    await tester.ensureVisible(doneFinder);
    await tester.tap(doneFinder);
    await tester.pumpAndSettle();

    expect(find.text('result:level3'), findsOneWidget);
  });
}
