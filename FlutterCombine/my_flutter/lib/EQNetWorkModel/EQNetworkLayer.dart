import 'package:http/http.dart';
import 'dart:convert';
import 'package:statefull_widget/Extension/Extensions.dart';
import 'dart:typed_data';

abstract class FINetworkResource {
  String methodName;
  HttpMethod method;
  Map<String, String> headers;
  Map<String, dynamic> params;
  ContentEncoding contentEncoding;
  String baseUrlPath;
}

enum ContentEncoding { url, json }

/// The HTTP method of the request.
class HttpMethod extends Enum<String> {
  const HttpMethod(String val) : super(val);

  static const HttpMethod GET = const HttpMethod('GET');
  static const HttpMethod POST = const HttpMethod('POST');
  static const HttpMethod PUT = const HttpMethod('PUT');
  static const HttpMethod DELETE = const HttpMethod('DELETE');
}


class APIRequest extends Request {
  final FINetworkResource resource;

  APIRequest(this.resource) : super(resource.method.value, Uri.parse(
                '${resource.baseUrlPath}'));

  @override
  Map<String, String> get headers => this.resource.headers;

  @override 
  String get body => json.encode(this.resource.params);

  @override
  Uint8List get bodyBytes  {
    if (resource.params == null) {
      return new Uint8List(0);
    }

    if (resource.contentEncoding == ContentEncoding.url) {
     final queryParameters = Uri(queryParameters: resource.params);
      List<int> bodyBytes = utf8.encode(queryParameters.query);

      return bodyBytes;
    } else {
      final encodeParams = Utf8Codec().encode(body);
      return Uint8List.fromList(encodeParams);
    }
  }
}