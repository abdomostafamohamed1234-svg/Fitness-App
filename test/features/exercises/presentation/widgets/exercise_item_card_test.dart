import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/core/theme/app_theme.dart';
import 'package:flowery/features/exercises/domain/entities/exercises_entity.dart';
import 'package:flowery/features/exercises/presentation/view_model/base_state/exercise_state.dart';
import 'package:flowery/features/exercises/presentation/view_model/cubit/exercise_cubit.dart';
import 'package:flowery/features/exercises/presentation/view_model/events/exercise_events.dart';
import 'package:flowery/features/exercises/presentation/widgets/exercise_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import '../../../../helpers/exercise_test_helpers.dart';

void main() {
  late MockExerciseCubit mockCubit;

  const exercise = ExerciseEntity(
    id: "e1",
    exercise: "Bench Press",
    difficultyLevel: "Beginner",
    targetMuscleGroup: "Chest",
    primaryEquipment: "Barbell",
    mechanics: "Compound",
    shortYoutubeDemonstrationLink: "https://youtu.be/abc123",
  );

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

  Future<void> pumpCard(WidgetTester tester) {
    return tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.darkTheme,
        home: BlocProvider<ExerciseCubit>.value(
          value: mockCubit,
          child: const Scaffold(body: ExerciseItemCard(exercise: exercise)),
        ),
      ),
    );
  }

  testWidgets("renders the exercise name, equipment, and target muscle", (
    tester,
  ) async {
    await mockNetworkImagesFor(() async {
      await pumpCard(tester);

      expect(find.text("Bench Press"), findsOneWidget);
      expect(find.textContaining("Barbell"), findsOneWidget);
      expect(find.text("Chest"), findsOneWidget);
    });
  });

  testWidgets(
    "shows a play button over the thumbnail when no video is playing",
    (tester) async {
      await mockNetworkImagesFor(() async {
        await pumpCard(tester);

        expect(find.byIcon(Icons.play_arrow_rounded), findsOneWidget);
      });
    },
  );

  testWidgets(
    "tapping the thumbnail dispatches ToggleExerciseVideoEvent with this "
    "exercise's id",
    (tester) async {
      await mockNetworkImagesFor(() async {
        await pumpCard(tester);

        await tester.tap(find.byIcon(Icons.play_arrow_rounded));
        await tester.pump();

        final captured = verify(() => mockCubit.doEvent(captureAny())).captured;

        expect(captured, hasLength(1));
        final event = captured.single as ToggleExerciseVideoEvent;
        expect(event.exerciseId, "e1");
      });
    },
  );
}
