import 'package:octor/octor.dart';

import 'handlers/handlers.dart';

void main() async {
  var app = Octor();

  app.get('/hello', helloWorld);
  app.get('/greet/:name', Greeter());
  app.get('/fr/greet/:name', Greeter('Bonjour'));
  app.get('/greet/:name/async', AsyncGreeter());
  app.get('/de/greet/:name/async', AsyncGreeter('Halo'));
  app.any('/de/greet/:name/async',
      anyMethodHandler); // GET, POST, PUT, DELETE, PATCH and etc.

  await app.listen(port: 10080, host: ListenAt.anyIPv4);

  print('App started at: ${app.host.address}:${app.port}');
}
