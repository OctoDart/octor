library octor;

import 'dart:io';

import '../constants/listen_at.dart';

class HttpListener {
  int _port = 10080;
  InternetAddress _host = InternetAddress.loopbackIPv4;
  HttpServer _server;

  HttpListener([int port, ListenAt host]) {
    this.port = port;
    _host = ListenAddress.toInternetAddress(host);
  }

  set port(int port) {
    if (port != null) _port = port;
  }

  int get port {
    return _port;
  }

  InternetAddress get host {
    if (_server == null) {
      return _host;
    }
    return _server.address;
  }

  Future<HttpListener> listen() async {
    if (_server != null) throw 'Server already started';

    _server = await HttpServer.bind(_host, _port);
    return this;
  }

  void registerHandler(Function handler) {
    _server.listen(handler);
  }

  static Future<HttpListener> start([int port, ListenAt host]) async {
    return HttpListener(port, host).listen();
  }
}