import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/exception/app_exceptions.dart';
import '../api_controller.dart';

//TODO: http provider

class HttpApiProvider extends APIController {
  final String _liveBaseUrl = 'BASE URL';
  final int _timeOut = 30;

  Future<dynamic> _sendGetRequest(String path, {Map<String, String>? headers, Map<String, dynamic>? body, int? timeOut}) async {
    Map<String, String> header = <String, String>{'Content-Type': 'application/json; charset=UTF-8'};

    http.Response response = await http.get(Uri.https(_liveBaseUrl, path, body), headers: headers ?? header).timeout(
          Duration(seconds: timeOut ?? _timeOut),
          onTimeout: () => throw AppTimeoutException(),
        );
    //todo open for debugging
    // print('GET Res --> ${response.statusCode}');
    // print('GET Res --> ${response.body}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    }
    return null;
  }

  Future<dynamic> _sendPostRequest(String path, {Map<String, String>? headers, Map<String, dynamic>? body, int? timeOut}) async {
    Map<String, String> header = <String, String>{'Content-Type': 'application/json; charset=UTF-8'};

    http.Response response = await http.post(Uri.https(_liveBaseUrl, path), headers: headers ?? header, body: jsonEncode(body)).timeout(
          Duration(seconds: timeOut ?? _timeOut),
          onTimeout: () => throw AppTimeoutException(),
        );
    //todo open for debugging
    // print('POST Res --> ${response.statusCode}');
    // print('POST Res --> ${response.body}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    }
    return null;
  }

  /// ---------------------------------------------------- Providers -----------------------------------------------
  ///
  ///


}
