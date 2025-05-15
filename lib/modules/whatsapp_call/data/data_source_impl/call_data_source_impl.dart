import 'package:flower_tracking_app/modules/whatsapp_call/data/data_source/call_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/apis/api_executor/api_executor.dart';
import '../../../../core/apis/api_result/api_result.dart';

@Injectable(as: CallDataSource)
class CallDataSourceImpl implements CallDataSource {
  @override
  Future<ApiResult<void>> call(String phoneNumber) async {
    // TODO: implement call
    var result = await ApiExecutor.executeApi(() async {
      final url = Uri.parse('tel:$phoneNumber');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw Exception('Could not make phone call');
      }
    });

    switch (result) {
      case Success<void>():
        return Success(data: 'Call Launched');
      case Error<void>():
        return Error(error: 'Could not make phone call');
    }
  }
}
