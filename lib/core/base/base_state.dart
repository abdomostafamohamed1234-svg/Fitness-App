import 'package:equatable/equatable.dart';

enum StateType { initial, loading, success, error }

class BaseState<T> extends Equatable {
  final StateType state;
  final T? data;
  final Exception? exception;

  const BaseState({this.state = StateType.initial, this.data, this.exception});

  @override
  List<Object?> get props => [state, data, exception];

  const BaseState.initial()
    : state = StateType.initial,
      data = null,
      exception = null;

  const BaseState.loading()
    : state = StateType.loading,
      data = null,
      exception = null;

  const BaseState.success(this.data)
    : state = StateType.success,
      exception = null;

  const BaseState.error(this.exception) : state = StateType.error, data = null;

  // More readable in the UI
  R when<R>({
    required R Function(T data) success,
    required R Function() loading,
    R Function()? moreLoading,
    required R Function(Exception exception) error,
    required R Function() initial,
  }) {
    return switch (state) {
      StateType.initial => initial(),
      StateType.loading => loading(),
      StateType.success => success(data as T),
      StateType.error => error(exception!),
    };
  }
}
