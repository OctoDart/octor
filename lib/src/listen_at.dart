import 'dart:io';

enum ListenAt {
  localhost,
  localhost6,
  loopbackIPv4,
  loopbackIPv6,
  anyIPv4,
  anyIPv6,
}

const int DEFAULT_PORT = 10080;
const ListenAt DEFAULT_HOST = ListenAt.loopbackIPv4;

class ListenAddress {
  static InternetAddress toInternetAddress(ListenAt listenAt) {
    switch (listenAt) {
      case ListenAt.localhost:
      case ListenAt.loopbackIPv4:
        return InternetAddress.loopbackIPv4;

      case ListenAt.localhost6:
      case ListenAt.loopbackIPv6:
        return InternetAddress.loopbackIPv6;

      case ListenAt.anyIPv4:
        return InternetAddress.anyIPv4;

      case ListenAt.anyIPv6:
        return InternetAddress.anyIPv6;

      default:
        throw 'Unknown parameter';
    }
  }
}