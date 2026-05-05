import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

import '../../utils/getunsef_clint.dart';
import '../../utils/session.dart';
import '../../utils/toast_msg.dart';
import '../app_exception.dart';
import '../checkStatus.dart';
import 'baseapi_services.dart';


class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getGetApiResponse(context,String url) async {
    final token = await MySharedPreferences.getToken() ?? "";
    print("🔹 API GET Request URL: $url");
    dynamic responseJson;
    final client = getUnsafeClient();
    try {
      final response = await client.get(
        Uri.parse(url),
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token"
        },
      ).timeout(const Duration(seconds: 10));
      print("🔹 API GET Response Status Code: ${response.statusCode}");
      print("🔹 API GET Body: ${response.body}");
      if (response.statusCode == 200) {
        responseJson = jsonDecode(response.body);
        print("🔹 API GET Response Body: ${response.body}");
      } else if (response.statusCode == 500) {
        print("❌ Internal Server Error: ${response.body}");
        throw Exception("Internal Server Error. Please try again later.");
      } else {
        print("❌ Error: ${response.reasonPhrase}");
        responseJson = returnResponse(response);
      }
    } on SocketException {
      Utils.toastMessage("No Internet Connection");
      throw FetchDataException("No Internet Connection");
    } catch (e) {
      print("❌ Error: $e");
      throw Exception(e.toString());
    }
    return responseJson;
  }




  Future<dynamic> getPostApiResponse(
      String url,
      dynamic data, {
        Map<String, File>? files,
      }) async {
    final token = await MySharedPreferences.getToken() ?? "";
    print("🔹 Bearer Token: $token");
    print("🔹 API Request URL: $url");

    var headers = {
      'accept': '*/*',
      'Authorization': "Bearer $token",
    };

    try {
      late http.Response response;
      final client = getUnsafeClient();

      if (files == null || files.isEmpty) {
        headers['Content-Type'] = 'application/json';
        response = await client
            .post(
          Uri.parse(url),
          body: jsonEncode(data),
          headers: headers,
        )
            .timeout(const Duration(seconds: 20));
      } else {
        // ✅ Use IOClient’s HttpClient for multipart too
        final ioClient = HttpClient()
          ..badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
        final unsafeClient = IOClient(ioClient);

        var request = http.MultipartRequest("POST", Uri.parse(url));
        request.headers.addAll(headers);

        // Add text fields
        data.forEach((key, value) {
          request.fields[key] = value.toString();
        });

        // Add files
        for (var entry in files.entries) {
          final file = entry.value;
          if (file.existsSync()) {
            request.files.add(
              await http.MultipartFile.fromPath(
                entry.key,
                file.path,
                filename: file.path.split('/').last,
              ),
            );
          }
        }

        // ✅ Send using unsafeClient’s inner HttpClient
        final streamedResponse = await unsafeClient.send(request);
        response = await http.Response.fromStream(streamedResponse);
      }

      print("🔹 Response Status Code: ${response.statusCode}");
      print("🔹 Response Body: ${response.body}");

      if (response.statusCode >= 500) {
        throw Exception("Internal Server Error: ${response.statusCode}");
      }

      dynamic responseJson;
      if (response.body.isNotEmpty) {
        try {
          responseJson = jsonDecode(response.body);
        } catch (e) {
          print("⚠️ Failed to parse JSON, returning raw body");
          responseJson = response.body;
        }
      } else {
        responseJson = {};
      }

      if (responseJson is Map<String, dynamic> && responseJson.containsKey('success')) {
        final rawStatus = responseJson['success'];

        // ✅ Handle both string and bool safely
        if (rawStatus is bool) {
          ApiStatus.status = rawStatus;
        } else if (rawStatus is String) {
          ApiStatus.status = rawStatus.toLowerCase() == 'true';
        } else {
          ApiStatus.status = false;
        }

        print("🔹 API Status: ${ApiStatus.status}");
      }

      return responseJson;
    } on SocketException {
      Utils.toastMessage("No Internet Connection");
      throw FetchDataException("No Internet Connection");
    } catch (e, stackTrace) {
      print("❌ Error: $e");
      print("❌ Stack Trace: $stackTrace");
      // Utils.toastMessage(e.toString());
      rethrow;
    }
  }
  // Future<dynamic> getPostApiResponse(String  url, dynamic data) async {
  //   final token = await MySharedPreferences.getToken() ?? "";
  //   print("Bearer Token: $token");
  //   var headers = {
  //     'accept': '*/*',
  //     'Content-Type': 'application/json',
  //     'Authorization': "Bearer $token"
  //   };
  //   try {
  //     http.Response response = await http.post(
  //       Uri.parse(url),
  //       body: jsonEncode(data), // ✅ Ensure correct JSON format
  //       headers: headers,
  //     ).timeout(const Duration(seconds: 10));
  //
  //     print("Response Body: ${response.body}");
  //
  //     if (response.statusCode == 500) {
  //       throw Exception("Internal Server Error. Please try again later.");
  //     }
  //     dynamic responseJson = returnResponse(response);
  //     // ✅ Print API Status
  //     if (responseJson is Map<String, dynamic> && responseJson.containsKey('status')) {
  //       ApiStatus.status = responseJson['status'];
  //       print("API Status: ${ApiStatus.status}"); // ✅ Print status
  //     } else {
  //       print("API Response does not contain 'status' key.");
  //     }
  //     return responseJson;
  //   } on SocketException {
  //     Utils.toastMessage("No Internet Connection");
  //     throw FetchDataException("No Internet Connection");
  //   } catch (e) {
  //     Utils.toastMessage(e.toString());
  //     print("Error: $e");
  //     throw e;
  //   }
  // }
  @override
  Future<dynamic> getDeleteApiResponse(String url, Map<String, dynamic> body) async {
    dynamic responseJson;
    try {
      final token = await MySharedPreferences.getToken() ?? "";
      print("🔹 API GET Request URL: $url");
      var request = http.Request("DELETE", Uri.parse(url));
      request.headers.addAll({
        'accept': '*/*',
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token"
      });
      request.body = json.encode(body);
      http.StreamedResponse streamedResponse = await request.send();
      http.Response response = await http.Response.fromStream(streamedResponse);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 409:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
      case 500:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
            "Error Accorded while communication  with serverwith status code${response.statusCode}");
    }
  }


}
