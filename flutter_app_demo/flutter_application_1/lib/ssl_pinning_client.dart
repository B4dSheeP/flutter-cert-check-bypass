import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:flutter/services.dart';

class SSLPinningHttpClient{
  
  static Future<http.Client> getSSLPinningClient()  async {
    HttpClient client = HttpClient(context: await globalContext);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(client);
    return ioClient;
  }

  static Future<SecurityContext> get globalContext async {
      var sslCert = await rootBundle.load('assets/certificate.pem');
      SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
      securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
      return securityContext;
  }

}