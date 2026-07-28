// import 'package:flowery/core/base/base_state.dart';
// import 'package:flowery/features/home/domian/entities/food_for_you_model.dart';
// import 'package:flowery/features/home/domian/entities/recommendation_model.dart';
// import 'package:flowery/features/home/domian/entities/work_out_model.dart';

// class HomeStates {
//   final BaseState<FoodForYouModel> foodState;
//   final BaseState<WorkOutModel> workOutState;
//   final BaseState<RecommendationModel> recommendationState;

//   const HomeStates({
//     required this.foodState,
//     required this.workOutState,
//     required this.recommendationState,
//   });

//   factory HomeStates.initial() {
//     return const HomeStates(
//       foodState: BaseState.initial(),
//       workOutState: BaseState.initial(),
//       recommendationState: BaseState.initial(),
//     );
//   }
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/features/home/domian/entities/food_for_you_model.dart';
import 'package:flowery/features/home/domian/entities/profile_model.dart';
import 'package:flowery/features/home/domian/entities/recommendation_model.dart';
import 'package:flowery/features/home/domian/entities/work_out_model.dart';

class HomeStates {
  final BaseState<FoodForYouModel> foodState;
  final BaseState<WorkOutModel> workOutState;
  final BaseState<RecommendationModel> recommendationState;
  final BaseState<ProfileModel> profileState;

  const HomeStates({
    required this.foodState,
    required this.workOutState,
    required this.recommendationState,
    required this.profileState,
  });

  factory HomeStates.initial() {
    return const HomeStates(
      foodState: BaseState.initial(),
      workOutState: BaseState.initial(),
      recommendationState: BaseState.initial(),
      profileState: BaseState.initial(),
    );
  }

  HomeStates copyWith({
    BaseState<FoodForYouModel>? foodState,
    BaseState<WorkOutModel>? workOutState,
    BaseState<RecommendationModel>? recommendationState,
    BaseState<ProfileModel>? profileState,
  }) {
    return HomeStates(
      foodState: foodState ?? this.foodState,
      workOutState: workOutState ?? this.workOutState,
      recommendationState: recommendationState ?? this.recommendationState,
      profileState: profileState ?? this.profileState,
    );
  }
}
//   HomeStates copyWith({
//     BaseState<FoodForYouModel>? foodState,
//     BaseState<WorkOutModel>? workOutState,
//     BaseState<RecommendationModel>? recommendationState,
//   }) {
//     return HomeStates(
//       foodState: foodState ?? this.foodState,
//       workOutState: workOutState ?? this.workOutState,
//       recommendationState: recommendationState ?? this.recommendationState,
//     );
//   }
// }


// import 'package:flowery/core/base/base_state.dart';
// import 'package:flowery/features/home/domian/entities/food_for_you_model.dart';
// import 'package:flowery/features/home/domian/entities/recommendation_model.dart';
// import 'package:flowery/features/home/domian/entities/work_out_model.dart';

// class HomeStates {
//   final BaseState<FoodForYouModel> foodState;
//   final BaseState<WorkOutModel> workOutState;
//   final BaseState<RecommendationModel> recommendationState;

//   const HomeStates({
//     required this.foodState,
//     required this.workOutState,
//     required this.recommendationState,
//   });

//   factory HomeStates.initial() {
//     return const HomeStates(
//       foodState: BaseState.initial(),
//       workOutState: BaseState.initial(),
//       recommendationState: BaseState.initial(),
//     );
//   }

//   HomeStates copyWith({
//     BaseState<FoodForYouModel>? foodState,
//     BaseState<WorkOutModel>? workOutState,
//     BaseState<RecommendationModel>? recommendationState,
//   }) {
//     return HomeStates(
//       foodState: foodState ?? this.foodState,
//       workOutState: workOutState ?? this.workOutState,
//       recommendationState: recommendationState ?? this.recommendationState,
//     );
//   }
// }