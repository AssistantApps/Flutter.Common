import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../contracts/generated/uploaded_image_view_model.dart';
import '../contracts/results/result_with_value.dart';
import '../integration/dependencyInjection.dart';

class BaseApiService {
  final String _baseUrl;
  BaseApiService(this._baseUrl);

  Future<ResultWithValue<String>> apiGet(String url,
      {Map<String, String>? headers}) async {
    return await webGet('$_baseUrl/$url', headers: headers);
  }

  Future<ResultWithValue<String>> webGet(String url,
      {Map<String, String>? headers}) async {
    try {
      getLog().d('web get request to: $url');
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode != 200) {
        getLog().d("GET request not a 200 response");
        return ResultWithValue<String>(false, '', 'Not a 200 OK response');
      }
      return ResultWithValue<String>(true, response.body, '');
    } catch (exception) {
      getLog().e("BaseApiService GET Exception: ${exception.toString()}");
      return ResultWithValue<String>(false, '', exception.toString());
    }
  }

  Future<ResultWithValue<String>> apiPost(
    String url,
    dynamic body, {
    Map<String, String>? headers,
    void Function(Map<String, String>)? headerHandler,
  }) async {
    try {
      getLog().d('post request to: $_baseUrl/$url');
      getLog().d('post request body: $body');
      final response = await http.post(
        Uri.parse('$_baseUrl/$url'),
        body: body,
        headers: headers ?? {"Content-Type": "application/json"},
      );
      if (response.statusCode != 200) {
        getLog().e('Status Code: ${response.statusCode}.');
        getLog().e(
            'Not a 200 OK response "${response.body}". ${response.toString()}');
        return ResultWithValue<String>(
          false,
          response.body,
          response.reasonPhrase ?? 'Not a 200 OK response',
        );
      }
      int responseLength = response.body.length;
      String displayTest = responseLength > 100
          ? response.body.substring(0, 100)
          : response.body;
      getLog().d('post response body: $displayTest...');

      if (headerHandler != null) headerHandler(response.headers);

      return ResultWithValue<String>(true, response.body, '');
    } catch (exception) {
      getLog().e("BaseApiService POST Exception: ${exception.toString()}");
      return ResultWithValue<String>(false, '', exception.toString());
    }
  }

  Future<ResultWithValue<String>> apiPut(String url, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      getLog().d('put request to: $_baseUrl/$url');
      getLog().d('put request body: $body');
      final response = await http.put(
        Uri.parse('$_baseUrl/$url'),
        body: body,
        headers: headers ?? {"Content-Type": "application/json"},
      );
      if (response.statusCode != 200) {
        getLog().e('Status Code: ${response.statusCode}.');
        getLog().e('Not a 200 OK response ${response.body}');
        getLog().e('Message: ${response.reasonPhrase}');
        return ResultWithValue<String>(
          false,
          '',
          response.reasonPhrase ?? 'Not a 200 OK response',
        );
      }
      int responseLength = response.body.length;
      String displayTest = responseLength > 100
          ? response.body.substring(0, 100)
          : response.body;
      getLog().d('put response body: $displayTest...');
      return ResultWithValue<String>(true, response.body, '');
    } catch (exception) {
      getLog().e("BaseApiService PUT Exception: ${exception.toString()}");
      return ResultWithValue<String>(false, '', exception.toString());
    }
  }

  Future<ResultWithValue<String>> apiDelete(String url, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      getLog().d('delete request to: $_baseUrl/$url');
      getLog().d('delete request body: $body');
      final response = await http.delete(
        Uri.parse('$_baseUrl/$url'),
        body: body,
        headers: headers ?? {"Content-Type": "application/json"},
      );
      if (response.statusCode != 200) {
        getLog().e('Status Code: ${response.statusCode}.');
        getLog().e('Not a 200 OK response ${response.body}');
        getLog().e('Message: ${response.reasonPhrase}');
        return ResultWithValue<String>(
          false,
          '',
          response.reasonPhrase ?? 'Not a 200 OK response',
        );
      }
      int responseLength = response.body.length;
      String displayTest = responseLength > 100
          ? response.body.substring(0, 100)
          : response.body;
      getLog().d('delete response body: $displayTest...');
      return ResultWithValue<String>(true, response.body, '');
    } catch (exception) {
      getLog().e("BaseApiService DELETE Exception: ${exception.toString()}");
      return ResultWithValue<String>(false, '', exception.toString());
    }
  }

  Future<ResultWithValue<List<UploadedImageViewModel>>> apiPostFile(
      String url, List<String> filenames, List<Uint8List> fileContents) async {
    // var logger = getLog();

    // List<MultipartFile> multipartFiles = List.empty();
    // for (var fileIndex = 0; fileIndex < filenames.length; fileIndex++) {
    //   multipartFiles.add(MultipartFile.fromBytes(
    //     fileContents[fileIndex],
    //     filename: filenames[fileIndex],
    //   ));
    // }
    // FormData formData = FormData.fromMap({'files': multipartFiles});
    // try {
    //   getLog().d('post formdata request to: $url');
    //   final response = await _dio.post(url, data: formData);
    //   if (response.statusCode != 200) {
    //     getLog().e('Status Code: ${response.statusCode}.');
    //     return ResultWithValue<List<UploadedImageViewModel>>(
    //         false, null, 'Not a 200 OK response');
    //   }
    //   var result = (response.data as List)
    //       .map((e) => UploadedImageViewModel.fromJson(e))
    //       .toList();
    //   return ResultWithValue<List<UploadedImageViewModel>>(true, result, '');
    // } catch (exception) {
    //   getLog().e(
    //       "BaseApiService apiPostFormData Exception: ${exception.toString()}");
    //   return ResultWithValue<List<UploadedImageViewModel>>(
    //       false, List.empty(), exception.toString());
    // }
    return ResultWithValue<List<UploadedImageViewModel>>(
        false, List.empty(), 'Not implemented');
  }
}
