Server-side framework based on dart:io:HttpServer

## Warning

Package still in development.

I don't recommend to use it in production.

Any help is appreciated. 

Feel free to provide Pull Requests.

Let's make Dart one of better languages for server-side development.

## Usage

```dart
import 'package:octor/octor.dart';

class Greeter extends Callable {
  final String greeting;

  Greeter([this.greeting = 'Hello']);

  @override
  Future<dynamic> call(RequestContext context) {
    var response = context.response;

    response.write('$greeting!');

    return context.response.close();
  }
}

class AsyncGreeter extends Callable {
  final String greeting;

  AsyncGreeter([this.greeting = 'Hello']);

  @override
  Future<dynamic> call(RequestContext context) async {
    var response = context.response;
    response.bufferOutput = false;

    for (var i in [3, 2, 1]) {
      response.write('$i\n');
      await Future.delayed(Duration(seconds: 1));
    }
    response.write('$greeting!');

    return response.close();
  }
}

Future<dynamic> helloWorld(RequestContext context) {
  var response = context.response;

  response.write('Hello, World!');

  return response.close();
}

Future<dynamic> anyMethodHandler(RequestContext context) {
  var request = context.request;
  var response = context.response;

  response.write('${request.method} ${request.uri} handled by "any" method handler');

  return response.close();
}

void main() async {
  var app = Octor();

  app.get('/hello', helloWorld);
  app.get('/greet/:name', Greeter());
  app.get('/fr/greet/:name', Greeter('Bonjour'));
  app.get('/greet/:name/async', AsyncGreeter());
  app.get('/de/greet/:name/async', AsyncGreeter('Halo'));
  app.any('/de/greet/:name/async', anyMethodHandler); // GET, POST, PUT, DELETE, PATCH and etc.

  await app.listen(port: 10080, host: ListenAt.anyIPv4);

  print('App started at: ${app.host.address}:${app.port}');
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/OctoDart/octor/issues
