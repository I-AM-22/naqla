import 'dart:async';

class StreamSocket {
  final _socketResponse = StreamController<Map<String, dynamic>>();

  void Function(Map<String, dynamic>) get addResponse =>
      _socketResponse.sink.add;

  Stream<Map<String, dynamic>> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}
