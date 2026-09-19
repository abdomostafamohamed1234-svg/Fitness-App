import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flowery/feature/logout/presentation/veiw_model.dart/logout_cubit.dart';
import 'package:flowery/feature/logout/presentation/veiw_model.dart/logout_event.dart';
import 'package:flowery/feature/logout/presentation/veiw_model.dart/logout_state.dart';
import 'package:flowery/feature/profile/presentation/view/widget/profile_content.dart';
import 'package:flowery/feature/profile/presentation/view/widget/web_view_screen.dart';

@GenerateMocks([LogoutCubit])
import 'profile_content_test.mocks.dart';

class _RecordingNavigatorObserver extends NavigatorObserver {
  Route<dynamic>? pushedRoute;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    pushedRoute = route;
    super.didPush(route, previousRoute);
  }
}

void main() {
  late MockLogoutCubit mockLogoutCubit;

  setUp(() {
    mockLogoutCubit = MockLogoutCubit();
    when(mockLogoutCubit.state).thenReturn(LogoutStates.initial());
    when(mockLogoutCubit.stream)
        .thenAnswer((_) => const Stream<LogoutStates>.empty());
    when(mockLogoutCubit.close()).thenAnswer((_) async {});
  });

  /// Pumps [ProfileContent] wrapped in a [MaterialApp] with a generous
  /// screen height so every menu item is visible and tappable.
  Future<_RecordingNavigatorObserver> pumpProfileContent(
    WidgetTester tester, {
    String name = 'Sara Ahmed',
    String? imageUrl,
    bool isEnglish = true,
    ValueChanged<bool>? onLanguageChanged,
  }) async {
    final observer = _RecordingNavigatorObserver();

    // Use a tall screen so all menu items (including Logout) fit on screen.
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        navigatorObservers: [observer],
        home: BlocProvider<LogoutCubit>.value(
          value: mockLogoutCubit,
          child: Scaffold(
            body: ProfileContent(
              name: name,
              imageUrl: imageUrl,
              isEnglish: isEnglish,
              onLanguageChanged: onLanguageChanged ?? (_) {},
            ),
          ),
        ),
      ),
    );

    // Allow localizations to load
    await tester.pumpAndSettle();

    return observer;
  }

  testWidgets('يعرض الاسم وأيقونة الشخص الافتراضية لما مفيش صورة', (tester) async {
    await pumpProfileContent(tester, name: 'Sara Ahmed', imageUrl: null);

    expect(find.text('Sara Ahmed'), findsOneWidget);
    expect(find.byIcon(Icons.person), findsOneWidget);
  });

  testWidgets('يعرض الصورة بدل الأيقونة الافتراضية لما imageUrl موجود', (
    tester,
  ) async {
    await pumpProfileContent(
      tester,
      imageUrl: 'https://example.com/avatar.png',
    );

    final image = tester.widget<Image>(find.byType(Image));
    final provider = image.image as NetworkImage;
    expect(provider.url, 'https://example.com/avatar.png');
  });

  testWidgets('يعرض العلم/النص الصح لحالة اللغة ويستدعي onLanguageChanged', (
    tester,
  ) async {
    bool? changedTo;

    await pumpProfileContent(
      tester,
      isEnglish: true,
      onLanguageChanged: (value) => changedTo = value,
    );

    // The trailing text "(English)" is rendered inside a RichText
    expect(find.textContaining('(English)', findRichText: true), findsOneWidget);

    await tester.tap(find.byType(Switch));
    await tester.pump();

    expect(changedTo, isFalse);
  });

  testWidgets('الضغط على Security بيعمل push لـ WebViewScreen باللينك الصح', (
    tester,
  ) async {
    final observer = await pumpProfileContent(tester);

    await tester.tap(find.text('Security', findRichText: true));
    // Don't pump again — we only want the route, not the full WebViewScreen build

    final pushedRoute = observer.pushedRoute;
    expect(pushedRoute, isA<MaterialPageRoute<dynamic>>());

    // Build the route's widget using the ProfileContent's element context
    // (which carries the localization delegates via the MaterialApp above).
    final builtWidget = (pushedRoute as MaterialPageRoute).builder(
      tester.element(find.byType(ProfileContent)),
    );

    expect(builtWidget, isA<WebViewScreen>());
    final webViewScreen = builtWidget as WebViewScreen;
    expect(
      webViewScreen.url,
      'https://elevate-flutter-team.github.io/fitness-app-webviews/security.html',
    );
    expect(webViewScreen.title, 'Security');
  });

  testWidgets('الضغط على Privacy Policy بيعمل push لـ WebViewScreen باللينك الصح', (
    tester,
  ) async {
    final observer = await pumpProfileContent(tester);

    await tester.tap(find.text('Privacy Policy', findRichText: true));

    final pushedRoute = observer.pushedRoute as MaterialPageRoute;
    final webViewScreen = pushedRoute.builder(
      tester.element(find.byType(ProfileContent)),
    ) as WebViewScreen;

    expect(
      webViewScreen.url,
      'https://elevate-flutter-team.github.io/fitness-app-webviews/privacy-policy.html',
    );
    expect(webViewScreen.title, 'Privacy Policy');
  });

  testWidgets('الضغط على Help بيعمل push لـ WebViewScreen باللينك الصح', (
    tester,
  ) async {
    final observer = await pumpProfileContent(tester);

    await tester.tap(find.text('Help', findRichText: true));

    final pushedRoute = observer.pushedRoute as MaterialPageRoute;
    final webViewScreen = pushedRoute.builder(
      tester.element(find.byType(ProfileContent)),
    ) as WebViewScreen;

    expect(
      webViewScreen.url,
      'https://elevate-flutter-team.github.io/fitness-app-webviews/help.html',
    );
    expect(webViewScreen.title, 'Help');
  });

  testWidgets('الضغط على Logout بيفتح Dialog التأكيد', (tester) async {
    await pumpProfileContent(tester);

    await tester.tap(find.text('Logout', findRichText: true));
    await tester.pumpAndSettle();

    expect(find.text('Are You Sure To Close Application?'), findsOneWidget);
  });

  testWidgets('الضغط على NO في الـ Dialog بيقفلها من غير ما يستدعي LogoutCubit', (
    tester,
  ) async {
    await pumpProfileContent(tester);

    await tester.tap(find.text('Logout', findRichText: true));
    await tester.pumpAndSettle();

    await tester.tap(find.text('NO'));
    await tester.pumpAndSettle();

    expect(find.text('Are You Sure To Close Application?'), findsNothing);
    verifyNever(mockLogoutCubit.doAction(any));
  });

  testWidgets('الضغط على Yes في الـ Dialog بيقفلها ويستدعي doAction بـ DoLogoutEvent', (
    tester,
  ) async {
    await pumpProfileContent(tester);

    await tester.tap(find.text('Logout', findRichText: true));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Yes'));
    await tester.pumpAndSettle();

    expect(find.text('Are You Sure To Close Application?'), findsNothing);
    verify(
      mockLogoutCubit.doAction(argThat(isA<DoLogoutEvent>())),
    ).called(1);
  });
}