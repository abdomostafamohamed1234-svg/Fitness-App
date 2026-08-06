import 'package:flowery/feature/profile/presentation/view/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/feature/logout/presentation/veiw_model.dart/logout_cubit.dart';
import 'package:flowery/feature/logout/presentation/veiw_model.dart/logout_state.dart';
import 'package:flowery/feature/profile/domain/entities/profile_entity.dart';
import 'package:flowery/feature/profile/presentation/view_model/profile_cubit.dart';
import 'package:flowery/feature/profile/presentation/view_model/profile_state.dart';

@GenerateMocks([ProfileCubit, LogoutCubit, ProfileEntity])
import 'profile_screen_test.mocks.dart';

void main() {
  late MockProfileCubit mockProfileCubit;
  late MockLogoutCubit mockLogoutCubit;

  setUp(() {
    mockProfileCubit = MockProfileCubit();
    mockLogoutCubit = MockLogoutCubit();

    // ProfileScreen بيجيب LogoutCubit من الـ service locator (getIt) مباشرة
    GetIt.instance.reset();
    GetIt.instance.registerFactory<LogoutCubit>(() => mockLogoutCubit);

    when(mockLogoutCubit.close()).thenAnswer((_) async {});
    when(mockLogoutCubit.stream)
        .thenAnswer((_) => const Stream<LogoutStates>.empty());
    when(mockLogoutCubit.state).thenReturn(LogoutStates.initial());

    when(mockProfileCubit.close()).thenAnswer((_) async {});
  });

  tearDown(() {
    GetIt.instance.reset();
  });

  Future<void> pumpProfileScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        routes: {
          AppRoutes.login: (_) =>
              const Scaffold(body: Text('Login Screen Placeholder')),
        },
        home: BlocProvider<ProfileCubit>.value(
          value: mockProfileCubit,
          child: const ProfileScreen(),
        ),
      ),
    );
  }

  testWidgets('يعرض CircularProgressIndicator وقت تحميل البروفايل', (
    tester,
  ) async {
    when(mockProfileCubit.state).thenReturn(
      const ProfileStates(profileState: BaseState.loading()),
    );
    when(mockProfileCubit.stream)
        .thenAnswer((_) => const Stream<ProfileStates>.empty());

    await pumpProfileScreen(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('يعرض رسالة الخطأ لما تحميل البروفايل يفشل', (tester) async {
    final exception = Exception('لا يوجد اتصال بالإنترنت');

    when(mockProfileCubit.state).thenReturn(
      ProfileStates(profileState: BaseState.error(exception)),
    );
    when(mockProfileCubit.stream)
        .thenAnswer((_) => const Stream<ProfileStates>.empty());

    await pumpProfileScreen(tester);

    expect(
      find.textContaining('حصل خطأ أثناء تحميل البروفايل'),
      findsOneWidget,
    );
  });

  testWidgets('يعرض ProfileContent بالاسم والصورة الصح لما التحميل ينجح', (
    tester,
  ) async {
    final mockEntity = MockProfileEntity();
    when(mockEntity.name).thenReturn('Mona Ali');
    when(mockEntity.profileImage).thenReturn('https://example.com/a.png');

    when(mockProfileCubit.state).thenReturn(
      ProfileStates(profileState: BaseState.success(mockEntity)),
    );
    when(mockProfileCubit.stream)
        .thenAnswer((_) => const Stream<ProfileStates>.empty());

    await pumpProfileScreen(tester);

    expect(find.text('Mona Ali'), findsOneWidget);
  });

  testWidgets(
    'يعمل navigate لصفحة اللوجن لما LogoutCubit يرجع success',
    (tester) async {
      when(mockProfileCubit.state).thenReturn(ProfileStates.initial());
      when(mockProfileCubit.stream)
          .thenAnswer((_) => const Stream<ProfileStates>.empty());

      when(mockLogoutCubit.state).thenReturn(LogoutStates.initial());
      when(mockLogoutCubit.stream).thenAnswer(
        (_) => Stream.value(
          const LogoutStates(logoutState: BaseState.success(null)),
        ),
      );

      await pumpProfileScreen(tester);
      await tester.pumpAndSettle();

      expect(find.text('Login Screen Placeholder'), findsOneWidget);
    },
  );

  testWidgets(
    'يعرض SnackBar بفشل تسجيل الخروج لما LogoutCubit يرجع error',
    (tester) async {
      when(mockProfileCubit.state).thenReturn(ProfileStates.initial());
      when(mockProfileCubit.stream)
          .thenAnswer((_) => const Stream<ProfileStates>.empty());

      when(mockLogoutCubit.state).thenReturn(LogoutStates.initial());
      when(mockLogoutCubit.stream).thenAnswer(
        (_) => Stream.value(
          LogoutStates(logoutState: BaseState.error(Exception('failed'))),
        ),
      );

      await pumpProfileScreen(tester);
      await tester.pump(); // بناء الودجت
      await tester.pump(); // ظهور الـ SnackBar

      expect(find.text('فشل تسجيل الخروج، حاولي تاني'), findsOneWidget);
    },
  );
}