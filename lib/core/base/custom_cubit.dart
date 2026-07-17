import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A base Cubit that carries a [StreamController] for one-shot side-effect
/// events (navigation, dialogs, toasts, …) that should not be part of State.
///
/// [TempEvent] – the sealed class for ephemeral events.
/// [S]         – the State class emitted by the cubit.
abstract class CustomCubit<TempEvent, S> extends Cubit<S> {
  CustomCubit(super.initialState) {
    streamController = StreamController<TempEvent>.broadcast();
    cubitStream = streamController.stream;
  }

  late final StreamController<TempEvent> streamController;
  late final Stream<TempEvent> cubitStream;

  @override
  Future<void> close() {
    streamController.close();
    return super.close();
  }
}
