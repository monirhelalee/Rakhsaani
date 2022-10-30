import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rakhsaani/core/utils/urls.dart';

import 'logger_helper.dart';

enum ApiUrlType {
  login,
  signUp,
}

class ApiClient {
  http.Client? httClient;

  ApiClient({this.httClient}) {
    httClient ??= http.Client();
  }

  Future<http.Response> getRequest(String url) async {
    var completeUrl = _buildUrl(url);
    logger.i("Checking for Get API start & end point $completeUrl");
    var headers = await _getHeaders();
    return httClient!.get(Uri.parse(completeUrl), headers: headers);
  }

  Future<http.Response> postRequest(String url, Map<String, dynamic> body,
      {Duration? timeout, bool checkAccessValidity = true}) async {
    var completeUrl = _buildUrl(url);
    logger.i("Checking for Post API start & end point $completeUrl");
    var headers = await _getHeaders();
    var encodedBody = json.encode(body);
    return httClient!
        .post(Uri.parse(completeUrl), headers: headers, body: encodedBody);
  }

  Future<http.Response> deleteRequest(
      String url, Map<String, dynamic> body) async {
    var completeUrl = _buildUrl(url);
    logger.i("Checking for Post API start & end point $completeUrl");
    var headers = await _getHeaders();
    var encodedBody = json.encode(body);
    return httClient!
        .delete(Uri.parse(completeUrl), headers: headers, body: encodedBody);
  }

  Future<http.Response> putRequest(String url, Map<String, dynamic> body,
      {Duration? timeout}) async {
    var completeUrl = _buildUrl(url);
    logger.i("Checking for Put API start & end point $completeUrl");
    var headers = await _getHeaders();
    var encodedBody = json.encode(body);
    return httClient!.put(completeUrl, headers: headers, body: encodedBody);
  }

  Future<Map<String, String>> _getHeaders() async {
    Map<String, String> headers = {
      'Content-Type': 'text/plain',
    };
    return headers;
  }

  _buildUrl(String partialUrl) {
    String baseUrl = Urls.baseUrl;
    return baseUrl + partialUrl;
  }
}
