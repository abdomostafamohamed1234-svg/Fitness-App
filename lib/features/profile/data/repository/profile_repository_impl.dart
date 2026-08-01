// import 'package:dio/dio.dart';
// import 'package:flowery/features/api/api/profile_api_client.dart';
// import 'package:flowery/features/api/datasourse/local_datasourse_impl.dart';
// import 'package:flowery/features/domain/entities/profile_entity.dart';
// import 'package:flowery/features/domain/repository/profile_%20repository_contract.dart';
// import 'package:injectable/injectable.dart';
// import 'package:flowery/core/base/base_response.dart';


// @Injectable(as: ProfileRepository)
// class ProfileRepositoryImpl implements ProfileRepository {
//   ProfileRepositoryImpl(this._apiClient, this._tokenLocalDataSource);

//   final ProfileApiClient _apiClient;
//   final TokenLocalDataSource _tokenLocalDataSource;

//   @override
//   Future<Result<ProfileEntity>> getProfile() async {
//     try {
//       final response = await _apiClient.getProfile();

//       // مجرد وصول شاشة البروفايل هنا معناه إن المستخدم مسجل دخول وعنده توكين
//       // شغال (غالبًا اتخزن أصلاً وقت الـ login). لو التوكين بييجي كجزء من
//       // response البروفايل نفسه، خزنيه هنا زي المثال التالي:
//       // if (response.token != null) {
//       //   await _tokenLocalDataSource.saveToken(response.token!);
//       // }
//       // ده اللي هيخلي فيتشر الـ logout بعدين يقدر ياخد التوكين من نفس المكان
//       // (TokenLocalDataSource.getToken()) بدل ما يدور عليه في مكان تاني.

//       return Result.success(response.toEntity());
//     } on DioException catch (exception) {
//       return Result.error(exception);
//     } catch (exception) {
//       return Result.error(exception);
//     }
//   }
// }






import 'package:dio/dio.dart';
import 'package:flowery/features/profile/api/api/profile_api_client.dart';
import 'package:flowery/features/profile/domain/entities/profile_entity.dart';
import 'package:flowery/features/profile/domain/repository/profile_%20repository_contract.dart';
import 'package:injectable/injectable.dart';
import 'package:flowery/core/base/base_response.dart';


@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._apiClient);

  final ProfileApiClient _apiClient;

  @override
  Future<Result<ProfileEntity>> getProfile() async {
    try {
      final response = await _apiClient.getProfile();
      return Success(data: response.toEntity());
    } on DioException catch (exception) {
      return Error(exception: exception);
    } catch (exception) {
      return Error(exception: exception is Exception ? exception : Exception(exception.toString()));
    }
  }
}