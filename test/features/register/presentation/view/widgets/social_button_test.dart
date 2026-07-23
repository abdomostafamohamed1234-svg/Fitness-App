import 'package:flowery/features/register/presentation/view/widgets/social_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/pump_app.dart';

void main() {
  testWidgets('Displays the given icon when an icon is provided', (
    tester,
  ) async {
    await tester.pumpApp(SocialButton(icon: Icons.facebook, onTap: () {}));

    expect(find.byIcon(Icons.facebook), findsOneWidget);
  });

  testWidgets('Displays the given label when no icon is provided', (
    tester,
  ) async {
    await tester.pumpApp(SocialButton(label: 'G', onTap: () {}));

    expect(find.text('G'), findsOneWidget);
    expect(find.byType(Icon), findsNothing);
  });

  testWidgets('Calls onTap when the button is tapped', (tester) async {
    var tapped = false;
    await tester.pumpApp(
      SocialButton(icon: Icons.apple, onTap: () => tapped = true),
    );

    await tester.tap(find.byType(SocialButton));
    await tester.pump();

    expect(tapped, isTrue);
  });
}