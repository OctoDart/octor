import 'package:octor/octor.dart';

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