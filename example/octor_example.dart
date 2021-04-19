import 'dart:io';

import 'package:octor/octor.dart';

class GreetCallabe extends Callable {
  String _greetable = 'World';

  GreetCallabe(String greetable) {
    if (greetable != null) _greetable = greetable;
  }

  @override
  Future<dynamic> call(HttpRequest request) {
    request.response.write('Hello, ${_greetable}!');
    request.response.close();
    return null;
  }
}

void helloWorld(HttpRequest request) {
  request.response.write('Hello, World!');
  request.response.close();
}

void main() async {
  var app = Octor();

  app.get('/', helloWorld);
  app.get('/greet/John', GreetCallabe('John'));

  await app.listen(port: 10080, host: ListenAt.anyIPv4);

  print('App started at: ${app.host.address}:${app.port}');
}
