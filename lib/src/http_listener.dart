library octor;

import 'dart:io';

import 'listen_at.dart';

class HttpListener {
  final int _port;
  InternetAddress _host = InternetAddress.loopbackIPv4;
  late HttpServer _server;

  HttpListener([this._port = DEFAULT_PORT, ListenAt host = DEFAULT_HOST]) {
    _host = ListenAddress.toInternetAddress(host);
  }

  int get port {
    return _port;
  }

  InternetAddress get host {
    return _host;
  }

  Future<HttpListener> listen() async {
    _server = await HttpServer.bind(_host, _port);
    return this;
  }

  void registerHandler(Function(HttpRequest) handler) {
    _server.listen(handler);
  }

  static Future<HttpListener> start(
      [int port = DEFAULT_PORT, ListenAt host = DEFAULT_HOST]) async {
    return HttpListener(port, host).listen();
  }
}
