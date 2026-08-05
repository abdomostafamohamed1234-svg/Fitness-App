import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flowery/features/home/presentation/view/widgets/home_header_widget.dart';
import 'package:flowery/features/home/presentation/view_model/home_cubit.dart';
import 'package:flowery/features/home/presentation/view_model/home_event.dart';
import 'package:flowery/features/home/presentation/view_model/home_state.dart';

/// ASSUMPTIONS (I don't have home_cubit.dart / home_state.dart / the
/// profile model source, so these are inferred purely from how
/// `HomeHeaderWidget` reads them: `state.profileState.data?.firstName`
/// and `state.profileState.data?.photo`):
///
/// - `HomeCubit` extends `Cubit<HomeStates>`.
/// - `HomeStates` has a `profileState` field of some `BaseState<T>` type
///   with `.data` on it (same `BaseState` used elsewhere in the app, see
///   home_body.dart's `_buildSection`).
/// - `BaseState` exposes a `.data` getter directly (not just via `.when`),
///   since that's how `HomeHeaderWidget` reads it: `state.profileState.data`.
/// - The profile "data" object has `firstName` (String) and `photo`
///   (String, non-nullable per `profile!.photo`).
///
/// If any of this doesn't match your real types, you mainly need to adjust
/// `_FakeHomeCubit`'s constructor call and the `_buildState(...)` helper —
/// the test bodies themselves don't need to change.
///
/// You'll likely need to swap `_FakeHomeCubit` for `MockHomeCubit` (via
/// mocktail/bloc_test) once the real `HomeStates`/`BaseState` shape is
/// known, but a hand-rolled fake avoids adding a new test dependency here.
class _FakeHomeCubit extends Cubit<HomeStates> implements HomeCubit {
  _FakeHomeCubit(super.initialState);

  @override
  void doAction(HomeEvents action) {}
}

Widget _wrap(HomeStates state) {
  return MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.black,
      body: BlocProvider<HomeCubit>(
        create: (_) => _FakeHomeCubit(state),
        child: const HomeHeaderWidget(),
      ),
    ),
  );
}

void main() {
  group('HomeHeaderWidget', () {
    testWidgets('shows the default "Elevate" greeting when there is no profile',
        (tester) async {
      // NOTE: replace `HomeStates()` / `BaseState.initial()` below with
      // however your real HomeStates/BaseState are constructed if this
      // doesn't compile as-is.
      await tester.pumpWidget(_wrap(HomeStates.initial()));

      expect(find.textContaining('Hi Elevate'), findsOneWidget);
      expect(find.text("Let's Start Your Day"), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);
    });
  });
}