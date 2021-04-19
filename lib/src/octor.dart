library octor;

import 'dart:core';
import 'dart:io';

import './constants/listen_at.dart';
import './handlers/callable.dart';
import './core/http_listener.dart';

class Octor {
  bool get isAwesome => true;

  HttpListener _httpListener;

  HttpListener get httpListener {
    return _httpListener;
  }

  InternetAddress get host {
    return httpListener.host;
  }

  int get port {
    return httpListener.port;
  }

  Future<Octor> start({int port, ListenAt host}) async {
    _httpListener = await HttpListener.start(port, host);
    _httpListener.registerHandler(_handler);
    return this;
  }

  Future<Octor> listen({int port, ListenAt host}) async {
    await start(port: port, host: host);
    return this;
  }

  final routes = <String, dynamic>{};

  Future<dynamic> _handler(HttpRequest request) {
    var route = request.method + ' ' + request.uri.toString();
    var handler = routes[route];

    if (handler == null) {
      request.response.statusCode = HttpStatus.notFound;
      return request.response.close();
    }

    return handler(request);
  }

  void _handlerCheck(dynamic handler) {
    if (!(handler is Callable || handler is Function)) {
      throw 'Handler method should be type of Function or inherit Callable';
    }
  }
  
  Octor _handlerRegister(String method, String route, dynamic handler) {
    _handlerCheck(handler);
    routes[method + ' ' + route] = handler;
    return this;
  }
  
  Octor get(String route, dynamic handler) {
    return _handlerRegister('GET', route, handler);
  }

  Octor post(String route, dynamic handler) {
    return _handlerRegister('GET', route, handler);
  }

  Octor put(String route, dynamic handler) {
    return _handlerRegister('GET', route, handler);
  }

  Octor patch(String route, dynamic handler) {
    return _handlerRegister('GET', route, handler);
  }

  Octor delete(String route, dynamic handler) {
    return _handlerRegister('GET', route, handler);
  }

  Octor options(String route, dynamic handler) {
    return _handlerRegister('GET', route, handler);
  }

  Octor head(String route, dynamic handler) {
    return _handlerRegister('GET', route, handler);
  }
}
