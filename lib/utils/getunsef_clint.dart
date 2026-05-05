import 'dart:io';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;

http.Client getUnsafeClient() {
  final ioClient = HttpClient()
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
  return IOClient(ioClient);
}