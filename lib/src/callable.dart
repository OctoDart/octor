library octor;

import 'request_context.dart';

abstract class Callable {
  Future<dynamic> call(RequestContext context);
}
