import 'package:octor/octor.dart';

Future<dynamic> helloWorld(RequestContext context) {
  var response = context.response;

  response.write('Hello, World!');

  return response.close();
}