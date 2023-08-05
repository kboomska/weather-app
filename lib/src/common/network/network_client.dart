import 'dart:convert';
import 'dart:io';

import 'package:weather_service/src/common/network/network_client_exception.dart';
import 'package:weather_service/src/common/network/http_client.dart';

abstract interface class INetworkClient {
  Future<T> get<T>(
    String host,
    String path,
    T Function(dynamic json) parser,
  );

  Future<T> post<T>(
    String host,
    String path,
    T Function(dynamic json) parser,
    Map<String, dynamic> bodyParameters, [
    Map<String, dynamic>? urlParameters,
  ]);
}

class NetworkClientImpl implements INetworkClient {
  final IHttpClient _httpClient;

  const NetworkClientImpl({
    required IHttpClient httpClient,
  }) : _httpClient = httpClient;

  Uri _makeUri(String host, String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('$host$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  @override
  Future<T> get<T>(
    String host,
    String path,
    T Function(dynamic json) parser,
  ) async {
    final url = Uri.parse('$host$path');

    try {
      final request = await _httpClient.getUrl(url);
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());
      final result = parser(json);
      return result;
    } on SocketException {
      throw NetworkClientException(NetworkClientExceptionType.network);
    } catch (_) {
      throw NetworkClientException(NetworkClientExceptionType.other);
    }
  }

  @override
  Future<T> post<T>(
    String host,
    String path,
    T Function(dynamic json) parser,
    Map<String, dynamic> bodyParameters, [
    Map<String, dynamic>? urlParameters,
  ]) async {
    final url = _makeUri(
      host,
      path,
      urlParameters,
    );

    try {
      final request = await _httpClient.postUrl(url);
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(bodyParameters));
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());
      final result = parser(json);
      return result;
    } on SocketException {
      throw NetworkClientException(NetworkClientExceptionType.network);
    } catch (_) {
      throw NetworkClientException(NetworkClientExceptionType.other);
    }
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder).toList().then((jsonStrings) {
      return jsonStrings.join();
    }).then((jsonString) => json.decode(jsonString));
  }
}
