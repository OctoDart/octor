import 'package:octor/octor.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    var octor = Octor();

    test('First Test', () {
      expect(octor.isAwesome, isTrue);
    });
  });
}
