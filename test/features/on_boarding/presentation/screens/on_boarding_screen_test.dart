import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/routing_generator.dart';
import 'package:flowery/features/on_boarding/presentation/assets/on_boarding_assets_navigation.dart';
import 'package:flowery/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:flowery/features/on_boarding/presentation/view_model/cubit/on_boarding_cubit.dart';
import 'package:flowery/features/on_boarding/presentation/view_model/state/on_boarding_state.dart';
import 'package:flowery/features/on_boarding/presentation/widgets/blurred_background_image.dart';
import 'package:flowery/features/on_boarding/presentation/widgets/blurred_container.dart';
import 'package:flowery/features/on_boarding/presentation/widgets/pose_image.dart';
import 'package:flowery/features/on_boarding/presentation/widgets/skip_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnBoardingCubit extends MockCubit<OnBoardingState>
    implements OnBoardingCubit {}

void main() {
  late MockOnBoardingCubit viewModel;
  setUp(() {
    viewModel = MockOnBoardingCubit();
    when(
      () => viewModel.state,
    ).thenReturn(const OnBoardingState(pageNumber: 0));

    whenListen(viewModel, Stream.value(const OnBoardingState(pageNumber: 0)));
  });

  Widget createScreen() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: BlocProvider<OnBoardingCubit>.value(
        value: viewModel,
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          onGenerateRoute: RouteGenerator.getRoute,
          home: OnBoardingScreen(),
        ),
      ),
    );
  }

  testWidgets('Testing the existence of main widgets', (tester) async {
    await tester.pumpWidget(createScreen());

    expect(find.byType(BlurredBackgroundImage), findsOne);
    expect(find.byType(SkipButton), findsOne);
    expect(find.byType(PoseImage), findsOne);
    expect(find.byType(BlurredContainer), findsOne);
  });

  testWidgets('Testing the skip button', (tester) async {
    await tester.pumpWidget(createScreen());

    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    expect(find.text('No Route Found'), findsNWidgets(2));
  });

  testWidgets('Testing Navigation: 1st page -> 2nd page', (tester) async {
    whenListen(
      viewModel,
      Stream.fromIterable([
        const OnBoardingState(pageNumber: 0),
        const OnBoardingState(pageNumber: 1),
      ]),
      initialState: const OnBoardingState(pageNumber: 0),
    );
    await tester.pumpWidget(createScreen());

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.text('Next'), findsOne);
    expect(find.text('Back'), findsOne);
    expect(
      find.image(const AssetImage(OnBoardingAssetsNavigation.pose2)),
      findsOne,
    );
  });

  testWidgets('Testing Navigation: 2nd page -> 3rd page', (tester) async {
    whenListen(
      viewModel,
      Stream.fromIterable([
        const OnBoardingState(pageNumber: 1),
        const OnBoardingState(pageNumber: 2),
      ]),
      initialState: const OnBoardingState(pageNumber: 1),
    );
    await tester.pumpWidget(createScreen());

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.text('Do IT'), findsOne);
    expect(find.text('Back'), findsOne);
    expect(
      find.image(const AssetImage(OnBoardingAssetsNavigation.pose3)),
      findsOne,
    );
  });

  testWidgets('Testing Navigation: 3rd page -> 2nd page', (tester) async {
    whenListen(
      viewModel,
      Stream.fromIterable([
        const OnBoardingState(pageNumber: 2),
        const OnBoardingState(pageNumber: 1),
      ]),
      initialState: const OnBoardingState(pageNumber: 2),
    );
    await tester.pumpWidget(createScreen());

    await tester.tap(find.text('Back'));
    await tester.pumpAndSettle();

    expect(find.text('Next'), findsOne);
    expect(find.text('Back'), findsOne);
    expect(
      find.image(const AssetImage(OnBoardingAssetsNavigation.pose2)),
      findsOne,
    );
  });

    testWidgets('Testing Navigation: 2nd page -> 1st page', (tester) async {
    whenListen(
      viewModel,
      Stream.fromIterable([
        const OnBoardingState(pageNumber: 1),
        const OnBoardingState(pageNumber: 0),
      ]),
      initialState: const OnBoardingState(pageNumber: 1),
    );
    await tester.pumpWidget(createScreen());

    await tester.tap(find.text('Back'));
    await tester.pumpAndSettle();

    expect(find.text('Next'), findsOne);
    expect(
      find.image(const AssetImage(OnBoardingAssetsNavigation.pose1)),
      findsOne,
    );
  });
}
