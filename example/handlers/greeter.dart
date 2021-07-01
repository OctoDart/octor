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
