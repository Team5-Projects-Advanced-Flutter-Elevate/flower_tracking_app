import 'package:flower_tracking_app/modules/whatsapp_call/data/data_source/call_data_source.dart';
import 'package:flower_tracking_app/modules/whatsapp_call/domain/repo/call_repo.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/apis/api_result/api_result.dart';

@Injectable(as: CallRepo)
class CallRepoImpl implements CallRepo {
  CallDataSource callDataSource;
  CallRepoImpl(this.callDataSource);
  @override
  Future<ApiResult<void>> call(String phoneNumber) {
    // TODO: implement call
    return callDataSource.call(phoneNumber);
  }
}
