import 'dart:io';

class RequestContext {
  late final HttpRequest request;
  late final HttpResponse response;
  late final HttpHeaders headers;
  late final String path;
  late final String method;
  late final Map<String, dynamic> query;
  late final Map<String, String> params;
  late dynamic body;

  static RequestContext create(HttpRequest request) {
    var context = RequestContext();

    context.request = request;
    context.response = request.response;
    context.headers = request.headers;
    context.path = request.uri.path;
    context.method = request.method;
    context.params = {};
    context.query = {};
    context.body = {};

    /* ToDo: parse query parameters and attach to request context
    if (request.uri.hasQuery) {
      final queryParams = request.uri.queryParametersAll.entries;
      for(var entry in queryParams) {
        //context.query[entry] = {};
      }
    }
     */
    return context;
  }
}
