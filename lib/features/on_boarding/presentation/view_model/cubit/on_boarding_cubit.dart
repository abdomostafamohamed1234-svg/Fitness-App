import 'package:flowery/features/on_boarding/presentation/view_model/events/on_boarding_events.dart';
import 'package:flowery/features/on_boarding/presentation/view_model/state/on_boarding_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(const OnBoardingState());

  void doEvent(OnBoardingEvents event) {
    switch (event) {
      case ChangePageEvent():
        _changePage(event);
    }
  }

  void _changePage(ChangePageEvent event) {
    emit(state.copyWith(pageNumber: event.pageNumber));
  }
}
