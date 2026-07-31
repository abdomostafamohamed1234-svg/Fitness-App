import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/core/theme/app_theme.dart';
import 'package:flowery/features/exercises/domain/entities/levels_entity.dart';
import 'package:flowery/features/exercises/presentation/view_model/base_state/exercise_state.dart';
import 'package:flowery/features/exercises/presentation/view_model/cubit/exercise_cubit.dart';
import 'package:flowery/features/exercises/presentation/view_model/events/exercise_events.dart';
import 'package:flowery/features/exercises/presentation/widgets/level_selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../../helpers/exercise_test_helpers.dart';

void main() {
  late MockExerciseCubit mockCubit;

  const level1 = DifficultyLevelEntity(id: "l1", name: "Beginner");
  const level2 = DifficultyLevelEntity(id: "l2", name: "Advanced");

  setUpAll(() {
    registerFallbackValue(fallbackExerciseEvent);
  });

  setUp(() {
    mockCubit = MockExerciseCubit();
    whenListen(
      mockCubit,
      const Stream<ExerciseState>.empty(),
      initialState: const ExerciseState(),
    );
  });

  Future<void> pumpWidget(
    WidgetTester tester, {
    required String selectedLevelId,
  }) {
    return tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.darkTheme,
        home: BlocProvider<ExerciseCubit>.value(
          value: mockCubit,
          child: Scaffold(
            body: LevelSelectorWidget(
              levels: const [level1, level2],
              selectedLevelId: selectedLevelId,
            ),
          ),
        ),
      ),
    );
  }

  testWidgets("renders a tab for every level with its name", (tester) async {
    await pumpWidget(tester, selectedLevelId: level1.id!);

    expect(find.text("Beginner"), findsOneWidget);
    expect(find.text("Advanced"), findsOneWidget);
  });

  testWidgets(
    "tapping a non-selected level dispatches SelectDifficultyLevelEvent "
    "with the right old/new ids",
    (tester) async {
      await pumpWidget(tester, selectedLevelId: level1.id!);

      await tester.tap(find.text("Advanced"));
      await tester.pumpAndSettle();

      final captured = verify(() => mockCubit.doEvent(captureAny())).captured;

      expect(captured, hasLength(1));
      final event = captured.single as SelectDifficultyLevelEvent;
      expect(event.oldLevelId, level1.id);
      expect(event.newLevelId, level2.id);
    },
  );

  testWidgets(
    "tapping the already-selected level does NOT dispatch any event",
    (tester) async {
      await pumpWidget(tester, selectedLevelId: level1.id!);

      await tester.tap(find.text("Beginner"));
      await tester.pumpAndSettle();

      verifyNever(() => mockCubit.doEvent(any()));
    },
  );
}
