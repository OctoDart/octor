library octor;

import 'dart:core';
import 'dart:io';

import 'callable.dart';
import 'http_listener.dart';
import 'listen_at.dart';
import 'request_context.dart';

class Octor {
  bool get isAwesome => true;

  late HttpListener _httpListener;

  HttpListener get httpListener {
    return _httpListener;
  }

  InternetAddress get host {
    return httpListener.host;
  }

  int get port {
    return httpListener.port;
  }

  Future<Octor> start({required int port, required ListenAt host}) async {
    _httpListener = await HttpListener.start(port, host);
    _httpListener.registerHandler(_handler);
    return this;
  }

  Future<Octor> listen({required int port, required ListenAt host}) async {
    await start(port: port, host: host);
    return this;
  }

  final _handlers = <String, Map<String, dynamic>>{
    '_': {},
  };

  Future<dynamic> _handler(HttpRequest request) {
    var context = RequestContext.create(request);

    var handler = _handlers[context.method]![context.path] ?? _handlers['_']![context.path];

    if (handler == null) {
      context.response.statusCode = HttpStatus.notFound;
      context.response.write('${request.method} ${request.uri.toString()} not found');
      return context.response.close();
    }

    return handler(context);
  }

  void _handlerCheck(dynamic handler) {
    if (!(handler is Callable || handler is Function)) {
      throw 'Handler method should be type of Function or inherit Callable';
    }
  }

  Octor _handlerRegister(String method, String route, dynamic handler) {
    _handlerCheck(handler);
    if (_handlers[method] == null) {
      _handlers[method] = {};
    }
    _handlers[method]![route] = handler;
    return this;
  }

  Octor get(String route, dynamic handler) {
    return _handlerRegister('GET', route, handler);
  }

  Octor post(String route, dynamic handler) {
    return _handlerRegister('POST', route, handler);
  }

  Octor put(String route, dynamic handler) {
    return _handlerRegister('PUT', route, handler);
  }

  Octor patch(String route, dynamic handler) {
    return _handlerRegister('PATCH', route, handler);
  }

  Octor delete(String route, dynamic handler) {
    return _handlerRegister('DELETE', route, handler);
  }

  Octor options(String route, dynamic handler) {
    return _handlerRegister('OPTIONS', route, handler);
  }

  Octor head(String route, dynamic handler) {
    return _handlerRegister('HEAD', route, handler);
  }

  Octor connect(String route, dynamic handler) {
    return _handlerRegister('CONNECT', route, handler);
  }

  Octor mount(String route, dynamic handler) {
    return _handlerRegister('MOUNT', route, handler);
  }

  Octor trace(String route, dynamic handler) {
    return _handlerRegister('TRACE', route, handler);
  }

  Octor any(String route, dynamic handler) {
    return _handlerRegister('_', route, handler);
  }

  Octor all(String route, dynamic handler) => any(route, handler);


  @override
  Octor noSuchMethod(Invocation invocation) {
    return this;
  }
}
