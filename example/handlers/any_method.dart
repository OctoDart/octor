import 'package:octor/octor.dart';

Future<dynamic> anyMethodHandler(RequestContext context) {
  var request = context.request;
  var response = context.response;

  response.write(
      '${request.method} ${request.uri} handled by "any" method handler');

  return response.close();
}
