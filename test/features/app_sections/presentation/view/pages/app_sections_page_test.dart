import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/di/di_config.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/features/app_sections/presentation/view/pages/app_sections_page.dart';
import 'package:flowery/features/app_sections/presentation/view/widgets/custom_nav_bar.dart';
import 'package:flowery/features/app_sections/presentation/view_model/cubit/app_sections_cubit.dart';
import 'package:flowery/features/app_sections/presentation/view_model/cubit/app_sections_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
class MockAppSectionsCubit extends MockCubit<AppSectionsStates>
    implements AppSectionsCubit {}

void main() {
  late MockAppSectionsCubit mockCubit;
  late PageController pageController;

  setUp(() {
    mockCubit = MockAppSectionsCubit();
    pageController = PageController(initialPage: 0);

    const initialState = AppSectionsStates(currentIndex: 0);

    whenListen<AppSectionsStates>(
      mockCubit,
      const Stream<AppSectionsStates>.empty(),
      initialState: initialState,
    );


    when(() => mockCubit.pageController).thenReturn(pageController);
    when(() => mockCubit.setCurrentIndex(any())).thenAnswer((_) {});
    when(() => mockCubit.close()).thenAnswer((_) async {});

    if (getIt.isRegistered<AppSectionsCubit>()) {
      getIt.unregister<AppSectionsCubit>();
    }
    getIt.registerFactory<AppSectionsCubit>(() => mockCubit);
  });

  tearDown(() {
    pageController.dispose();
    if (getIt.isRegistered<AppSectionsCubit>()) {
      getIt.unregister<AppSectionsCubit>();
    }
  });

  Widget buildTestable() {
    return const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: AppSectionsPage(),
    );
  }

  group('AppSectionsPage', () {
    testWidgets('بتعرض شاشة الـ Home في البداية (currentIndex = 0)', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestable());
      await tester.pumpAndSettle();

      expect(find.text('Home Screen'), findsOneWidget);
    });

    testWidgets('بتعرض CustomNavBar تحت وبيبقى فيها 4 عناصر', (tester) async {
      await tester.pumpWidget(buildTestable());
      await tester.pumpAndSettle();

      final navBar = tester.widget<CustomNavBar>(find.byType(CustomNavBar));
      expect(navBar.items.length, 4);
      expect(navBar.currentIndex, 0);
    });

    testWidgets('الدوس على عنصر في الـ nav bar بيستدعي cubit.setCurrentIndex', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestable());
      await tester.pumpAndSettle();

      final navBar = tester.widget<CustomNavBar>(find.byType(CustomNavBar));
      navBar.onTap(2);

      // صياغة mocktail: verify(() => ...)
      verify(() => mockCubit.setCurrentIndex(2)).called(1);
    });

 
  testWidgets('لما الـ state تتغيّر لـ currentIndex جديد، الـ NavBar بتتحدث', (
  tester,
) async {
  final controller = StreamController<AppSectionsStates>();
  addTearDown(controller.close);

  whenListen<AppSectionsStates>(
    mockCubit,
    controller.stream,
    initialState: const AppSectionsStates(currentIndex: 0),
  );

  await tester.pumpWidget(buildTestable());
  await tester.pumpAndSettle();


  var navBar = tester.widget<CustomNavBar>(find.byType(CustomNavBar));
  expect(navBar.currentIndex, 0);

  controller.add(const AppSectionsStates(currentIndex: 3));
  await tester.pumpAndSettle();

  navBar = tester.widget<CustomNavBar>(find.byType(CustomNavBar));
  expect(navBar.currentIndex, 3);
});
}
);}