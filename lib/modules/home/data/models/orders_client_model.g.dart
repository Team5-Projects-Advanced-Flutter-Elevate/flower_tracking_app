// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_client_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PendingOrdersResponse _$PendingOrdersResponseFromJson(
  Map<String, dynamic> json,
) => PendingOrdersResponse(
  message: json['message'] as String,
  metadata:
      json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
  orders:
      (json['orders'] as List<dynamic>?)
          ?.map((e) => OrderDtoFirestore.fromJson(e as Map<String, dynamic>?))
          .toList(),
);

Map<String, dynamic> _$PendingOrdersResponseToJson(
  PendingOrdersResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'metadata': instance.metadata,
  'orders': instance.orders,
};

Metadata _$MetadataFromJson(Map<String, dynamic> json) => Metadata(
  currentPage: (json['currentPage'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  totalItems: (json['totalItems'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
);

Map<String, dynamic> _$MetadataToJson(Metadata instance) => <String, dynamic>{
  'currentPage': instance.currentPage,
  'totalPages': instance.totalPages,
  'totalItems': instance.totalItems,
  'limit': instance.limit,
};

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations

class _OrdersApiClient implements OrdersApiClient {
  _OrdersApiClient(this._dio, ) {
    baseUrl ??= 'https://flower.elevateegy.com/';
  }

  final Dio _dio;

  String? baseUrl;

   ParseErrorLogger? errorLogger;

  @override
  Future<PendingOrdersResponse> getPendingOrders({int page = 1}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': page};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<PendingOrdersResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            'api/v1/orders/pending-orders',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late PendingOrdersResponse _value;
    try {
      _value = PendingOrdersResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
