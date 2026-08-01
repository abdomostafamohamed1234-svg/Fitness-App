import 'package:flowery/config/api/api_keys.dart';
import 'package:flowery/features/change_password/data/data_source/change_password_local_data_source_contract.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChangePasswordLocalDataSourceContract)
class ChangePasswordLocalDataSourceImplementation
    implements ChangePasswordLocalDataSourceContract {
  final FlutterSecureStorage fss;
  ChangePasswordLocalDataSourceImplementation(this.fss);

  @override
  Future<void> updateUswerToken(String token) async {
    await fss.write(key: ApiKeys.token, value: token);
  }
}
