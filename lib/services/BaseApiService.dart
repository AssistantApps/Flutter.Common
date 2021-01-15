import 'package:http/http.dart' as http;

import '../contracts/results/resultWithValue.dart';

class BaseApiService {
  String _baseUrl;
  void Function(String) debug;
  void Function(String) error;
  BaseApiService(String baseUrl,
      {void Function(String) debugLogger, void Function(String) errorLogger}) {
    _baseUrl = baseUrl;
    debug = debugLogger ?? (String msg) => print(msg);
    error = errorLogger ?? (String msg) => print(msg);
  }

  Future<ResultWithValue<String>> apiPost(String url, dynamic body) async {
    try {
      debug('post request to: $_baseUrl/$url');
      debug('post request body: $body');
      final response = await http.post('$_baseUrl/$url',
          body: body, headers: {"Content-Type": "application/json"});
      if (response.statusCode != 200) {
        error('Status Code: ${response.statusCode}.');
        error('Not a 200 OK response ${response.body}');
        return ResultWithValue<String>(false, '', 'Not a 200 OK response');
      }
      debug('post response body: ${response.body}');
      return ResultWithValue<String>(true, response.body, '');
    } catch (exception) {
      error("BaseApiService POST Exception: ${exception.toString()}");
      return ResultWithValue<String>(false, '', exception.toString());
    }
  }

  Future<ResultWithValue<String>> apiGet(String url,
      {Map<String, String> headers}) async {
    return await this.webGet('$_baseUrl/$url', headers: headers);
  }

  Future<ResultWithValue<String>> webGet(String url,
      {Map<String, String> headers}) async {
    try {
      debug('web get request to: $url');
      final response = await http.get(url, headers: headers);
      if (response.statusCode != 200) {
        return ResultWithValue<String>(false, '', 'Not a 200 OK response');
      }
      return ResultWithValue<String>(true, response.body, '');
    } catch (exception) {
      error("BaseApiService GET Exception: ${exception.toString()}");
      return ResultWithValue<String>(false, '', exception.toString());
    }
  }
}
