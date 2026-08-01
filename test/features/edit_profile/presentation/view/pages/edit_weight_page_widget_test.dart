import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_theme.dart';
import 'package:flowery/features/edit_profile/presentation/view/pages/edit_weight_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpWeightPage(WidgetTester tester, {int initialWeight = 70}) {
    return tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
          theme: AppTheme.darkTheme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: EditWeightPage(initialWeight: initialWeight),
        ),
      ),
    );
  }

  testWidgets('renders the question and starts on the initial weight', (tester) async {
    await pumpWeightPage(tester, initialWeight: 90);

    expect(find.text('What is Your Weight?'), findsOneWidget);
    expect(find.text('90'), findsOneWidget);
  });

  testWidgets('pops with the selected weight when Done is pressed', (tester) async {
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
                    final result = await Navigator.of(context).push<int>(
                      MaterialPageRoute(
                        builder: (_) => const EditWeightPage(initialWeight: 90),
                      ),
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

    await tester.tap(find.widgetWithText(ElevatedButton, 'Done'));
    await tester.pumpAndSettle();

    expect(find.text('result:90'), findsOneWidget);
  });
}
