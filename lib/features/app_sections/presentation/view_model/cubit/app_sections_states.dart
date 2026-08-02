import 'package:equatable/equatable.dart';

class AppSectionsStates extends Equatable {
  final int currentIndex;
   const AppSectionsStates({required this.currentIndex});

   AppSectionsStates copyWith({int? currentIndex}) {
    return AppSectionsStates(currentIndex: currentIndex ?? this.currentIndex);
  }
    @override
  List<Object> get props => [currentIndex];
}
