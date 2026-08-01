import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_theme.dart';
import 'package:flowery/features/edit_profile/presentation/view/pages/edit_goal_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpGoalPage(WidgetTester tester, {String? initialGoal}) {
    return tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
          theme: AppTheme.darkTheme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: EditGoalPage(initialGoal: initialGoal),
        ),
      ),
    );
  }

  testWidgets('renders every goal option and disables Done until one is picked', (
    tester,
  ) async {
    await pumpGoalPage(tester);

    expect(find.text('Gain Weight'), findsOneWidget);
    expect(find.text('Lose Weight'), findsOneWidget);
    expect(find.text('Get Fitter'), findsOneWidget);

    final doneButton = tester.widget<ElevatedButton>(
      find.widgetWithText(ElevatedButton, 'Done'),
    );
    expect(doneButton.onPressed, isNull);
  });

  testWidgets('enables Done and pops with the picked value once an option is tapped', (
    tester,
  ) async {
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
                      MaterialPageRoute(builder: (_) => const EditGoalPage()),
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

    await tester.tap(find.text('Lose Weight'));
    await tester.pump();

    final doneFinder = find.widgetWithText(ElevatedButton, 'Done');
    await tester.ensureVisible(doneFinder);
    await tester.tap(doneFinder);
    await tester.pumpAndSettle();

    // The stored value stays the stable English string, not a translated label.
    expect(find.text('result:Lose Weight'), findsOneWidget);
  });
}
