import 'package:flowery/core/theme/app_theme.dart';
import 'package:flowery/features/edit_profile/presentation/view/widgets/selectable_option_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const options = {
    'level1': 'Rookie',
    'level2': 'Beginner',
    'level3': 'Intermediate',
  };

  Future<void> pumpList(
    WidgetTester tester, {
    required String? selected,
    required ValueChanged<String> onChanged,
  }) {
    return tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
          theme: AppTheme.darkTheme,
          home: Scaffold(
            body: SelectableOptionList(
              options: options,
              selected: selected,
              onChanged: onChanged,
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('renders the localized label for every option, not the raw value', (
    tester,
  ) async {
    await pumpList(tester, selected: null, onChanged: (_) {});

    expect(find.text('Rookie'), findsOneWidget);
    expect(find.text('Beginner'), findsOneWidget);
    expect(find.text('Intermediate'), findsOneWidget);
    expect(find.text('level1'), findsNothing);
  });

  testWidgets('reports the stable value (not the label) when an option is tapped', (
    tester,
  ) async {
    String? tappedValue;
    await pumpList(tester, selected: null, onChanged: (value) => tappedValue = value);

    await tester.tap(find.text('Beginner'));
    await tester.pump();

    expect(tappedValue, 'level2');
  });
}
