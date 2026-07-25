// import 'dart:developer';
// import 'package:flowery/core/base/base_state.dart';
// import 'package:flowery/features/home/domian/entities/food_for_you_model.dart';
// import 'package:flowery/features/home/domian/entities/recommendation_model.dart';
// import 'package:flowery/features/home/domian/entities/work_out_model.dart';
// import 'package:flowery/features/home/domian/use_case/use_case.dart';
// import 'package:flowery/features/home/presentation/view_model/home_event.dart';
// import 'package:flowery/features/home/presentation/view_model/home_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:injectable/injectable.dart';

// @injectable
// class HomeCubit extends Cubit<HomeStates> {
//   final HomeUseCase _homeUseCase;

//   HomeCubit(this._homeUseCase) : super(HomeStates.initial());

//   // ================== EVENTS ==================

//   void doAction(HomeEvents event) {
//     switch (event) {
//       case GetAllDataEvent():
//         _getAllData();
//       case GetFoodDataEvent():
//         _getFoodData();
//       case GetWorkOutDataEvent():
//         _getWorkOutData();
//       case GetRecommendationDataEvent():
//         _getRecommendationData();
//     }
//   }

//   // ================== ALL ==================

//  Future<void> _getAllData() async {
//   await Future.wait([
//     _getFoodData(),
//     _getWorkOutData(),
//     _getRecommendationData(),
//   ]);
// }
//   // ================== FOOD ==================

//   Future<void> _getFoodData() async {
//     emit(state.copyWith(foodState: BaseState(isLoading: true)));

//     final BaseResponse<FoodForYouModel> response =
//         await _homeUseCase.callFoodData();

//     switch (response) {
//       case SuccessResponse(:final data):
//         emit(state.copyWith(foodState: BaseState(data: data)));
//       case ErrorResponse(:final error):
//         log(error.toString());
//         emit(state.copyWith(foodState: BaseState(error: error)));
//     }
//   }

//   // ================== WORK OUT ==================

//   Future<void> _getWorkOutData() async {
//     emit(state.copyWith(workOutState: BaseState(isLoading: true)));

//     final BaseResponse<WorkOutModel> response =
//         await _homeUseCase.callWorkOutData();

//     switch (response) {
//       case SuccessResponse(:final data):
//         emit(state.copyWith(workOutState: BaseState(data: data)));
//       case ErrorResponse(:final error):
//         log(error.toString());
//         emit(state.copyWith(workOutState: BaseState(error: error)));
//     }
//   }

//   // ================== RECOMMENDATION ==================

//   Future<void> _getRecommendationData() async {
//     emit(state.copyWith(recommendationState: BaseState(isLoading: true)));

//     final BaseResponse<RecommendationModel> response =
//         await _homeUseCase.callRecommendationData();

//     switch (response) {
//       case SuccessResponse(:final data):
//         emit(state.copyWith(recommendationState: BaseState(data: data)));
//       case ErrorResponse(:final error):
//         log(error.toString());
//         emit(state.copyWith(recommendationState: BaseState(error: error)));
//     }
//   }

//   @override
//   void emit(HomeStates state) {
//     if (isClosed) return;
//     super.emit(state);
//   }
// }




import 'dart:developer';
import 'package:flowery/core/base/base_response.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/features/home/domian/entities/food_for_you_model.dart';
import 'package:flowery/features/home/domian/entities/recommendation_model.dart';
import 'package:flowery/features/home/domian/entities/work_out_model.dart';
import 'package:flowery/features/home/domian/use_case/use_case.dart';
import 'package:flowery/features/home/presentation/view_model/home_event.dart';
import 'package:flowery/features/home/presentation/view_model/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeCubit extends Cubit<HomeStates> {
  final HomeUseCase _homeUseCase;

  HomeCubit(this._homeUseCase) : super(HomeStates.initial());

  // ================== EVENTS ==================

  void doAction(HomeEvents event) {
    switch (event) {
      case GetAllDataEvent():
        _getAllData();
      case GetFoodDataEvent():
        _getFoodData();
      case GetWorkOutDataEvent():
        _getWorkOutData();
      case GetRecommendationDataEvent():
        _getRecommendationData();
    }
  }

  // ================== ALL ==================

  Future<void> _getAllData() async {
    await Future.wait([
      _getFoodData(),
      _getWorkOutData(),
      _getRecommendationData(),
    ]);
  }

  // ================== FOOD ==================

  Future<void> _getFoodData() async {
    emit(state.copyWith(foodState: const BaseState.loading()));

    final Result<FoodForYouModel> response =
        await _homeUseCase.callFoodData();

    switch (response) {
      case Success(:final data):
        emit(state.copyWith(foodState: BaseState.success(data)));
      case Error(:final exception):
        log(exception.toString());
        emit(state.copyWith(foodState: BaseState.error(exception)));
    }
  }

  // ================== WORK OUT ==================

  Future<void> _getWorkOutData() async {
    emit(state.copyWith(workOutState: const BaseState.loading()));

    final Result<WorkOutModel> response =
        await _homeUseCase.callWorkOutData();

    switch (response) {
      case Success(:final data):
        emit(state.copyWith(workOutState: BaseState.success(data)));
      case Error(:final exception):
        log(exception.toString());
        emit(state.copyWith(workOutState: BaseState.error(exception)));
    }
  }

  // ================== RECOMMENDATION ==================

  Future<void> _getRecommendationData() async {
    emit(state.copyWith(recommendationState: const BaseState.loading()));

    final Result<RecommendationModel> response =
        await _homeUseCase.callRecommendationData();

    switch (response) {
      case Success(:final data):
        emit(state.copyWith(recommendationState: BaseState.success(data)));
      case Error(:final exception):
        log(exception.toString());
        emit(state.copyWith(recommendationState: BaseState.error(exception)));
    }
  }

  @override
  void emit(HomeStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}