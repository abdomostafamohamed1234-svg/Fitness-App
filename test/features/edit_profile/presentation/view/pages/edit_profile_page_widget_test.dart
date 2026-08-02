import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/di/di_config.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/core/theme/app_theme.dart';
import 'package:flowery/features/edit_profile/domain/entity/profile_entity.dart';
import 'package:flowery/features/edit_profile/domain/entity/user_entity.dart';
import 'package:flowery/features/edit_profile/presentation/view/pages/edit_profile_page.dart';
import 'package:flowery/features/edit_profile/presentation/view_model/cubit.dart';
import 'package:flowery/features/edit_profile/presentation/view_model/event.dart';
import 'package:flowery/features/edit_profile/presentation/view_model/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockEditProfileCubit extends MockCubit<EditProfileStates> implements EditProfileCubit {}

void main() {
  late _MockEditProfileCubit mockCubit;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;

  final user = UserEntity(
    id: '1',
    firstName: 'test',
    lastName: 'test',
    email: 'tadrous@gmail.com',
    gender: 'male',
    age: 70,
    weight: 70,
    height: 170,
    activityLevel: 'level1',
    goal: 'Gain weight',
    photo: '',
    createdAt: DateTime(2026, 7, 21),
  );
  late final loadedState = EditProfileStates(
    profileState: BaseState.success(ProfileEntity(message: 'success', user: user)),
  );

  setUpAll(() {
    registerFallbackValue(GetProfileEvent());
  });

  setUp(() {
    mockCubit = _MockEditProfileCubit();
    firstNameController = TextEditingController(text: 'test');
    lastNameController = TextEditingController(text: 'test');
    emailController = TextEditingController(text: 'tadrous@gmail.com');

    when(() => mockCubit.firstNameController).thenReturn(firstNameController);
    when(() => mockCubit.lastNameController).thenReturn(lastNameController);
    when(() => mockCubit.emailController).thenReturn(emailController);
    when(() => mockCubit.state).thenReturn(loadedState);
    whenListen(mockCubit, const Stream<EditProfileStates>.empty(), initialState: loadedState);

    // EditProfilePage resolves its cubit via getIt, so swap in the mock.
    getIt.registerFactory<EditProfileCubit>(() => mockCubit);
  });

  tearDown(() {
    getIt.reset();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
  });

  Future<void> pumpPage(WidgetTester tester) {
    return tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
          theme: AppTheme.darkTheme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const EditProfilePage(),
        ),
      ),
    );
  }

  testWidgets('renders an enabled Update button once the profile loads', (tester) async {
    await pumpPage(tester);
    await tester.pump();

    final button = tester.widget<ElevatedButton>(
      find.widgetWithText(ElevatedButton, 'Update'),
    );
    expect(button.onPressed, isNotNull);
  });

  testWidgets(
    'tapping Update sends the current field values in a single EditProfileEvent',
    (tester) async {
      await pumpPage(tester);
      await tester.pump();

      await tester.enterText(find.widgetWithText(TextFormField, 'First Name'), 'Ahmed');

      final updateButton = find.widgetWithText(ElevatedButton, 'Update');
      await tester.ensureVisible(updateButton);
      await tester.tap(updateButton);
      await tester.pump();

      final captured = verify(() => mockCubit.doEvent(captureAny())).captured;
      final editEvent = captured.whereType<EditProfileEvent>().last;

      expect(editEvent.firstName, 'Ahmed');
      expect(editEvent.lastName, 'test');
      expect(editEvent.email, 'tadrous@gmail.com');
      expect(editEvent.weight, 70);
      expect(editEvent.goal, 'Gain weight');
      expect(editEvent.activityLevel, 'level1');
    },
  );

  testWidgets('shows a spinner and disables Update while the update is in flight', (
    tester,
  ) async {
    final loadingState = loadedState.copyWith(editProfileState: const BaseState.loading());
    when(() => mockCubit.state).thenReturn(loadingState);
    whenListen(mockCubit, const Stream<EditProfileStates>.empty(), initialState: loadingState);

    await pumpPage(tester);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNull);
  });
}
