import 'package:equatable/equatable.dart';

class OnBoardingState extends Equatable {
  final int pageNumber;

  const OnBoardingState({this.pageNumber = 0});

  OnBoardingState copyWith({final int? pageNumber}) =>
      OnBoardingState(pageNumber: pageNumber ?? this.pageNumber);

  @override
  List<Object?> get props => [pageNumber];
}
