import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_theme.dart';
import 'package:flowery/features/edit_profile/presentation/view/widgets/editable_info_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpTile(WidgetTester tester, {required VoidCallback onTap}) {
    return tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
          theme: AppTheme.darkTheme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: EditableInfoTile(label: 'Your Weight', value: '90 Kg', onTap: onTap),
          ),
        ),
      ),
    );
  }

  testWidgets('renders the label, the tap-to-edit hint and the value', (tester) async {
    await pumpTile(tester, onTap: () {});

    expect(find.textContaining('Your Weight', findRichText: true), findsOneWidget);
    expect(find.textContaining('Tap To Edit', findRichText: true), findsOneWidget);
    expect(find.text('90 Kg'), findsOneWidget);
  });

  testWidgets('calls onTap when the value box is tapped', (tester) async {
    var tapped = false;
    await pumpTile(tester, onTap: () => tapped = true);

    await tester.tap(find.text('90 Kg'));
    await tester.pump();

    expect(tapped, isTrue);
  });
}
