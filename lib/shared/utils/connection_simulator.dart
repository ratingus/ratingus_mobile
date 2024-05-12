import 'dart:math';

class ConnectionSimulator<T> {
  static const int delay = 500;
  static const int errorRate = 10;

  Future<T> connect(Function() func) {
    return Future<T>.delayed(
        const Duration(milliseconds: delay),
            () {
          if (Random().nextInt(100) < errorRate) {
            throw Exception("Ошибка соединения");
          }
          return func();
        }
    );
  }
}