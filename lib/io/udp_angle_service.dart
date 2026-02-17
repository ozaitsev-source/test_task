import 'dart:io';
import 'dart:async';
import 'dart:convert';

final class UdpAngleReader extends Stream<double> {
  @override
  StreamSubscription<double> listen(
    void Function(double event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return _angleStreamController.stream.listen(onData, onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }

  static UdpAngleReader? _instance;
  late final StreamController<double> _angleStreamController;
  RawDatagramSocket? _udpSocket;

  factory UdpAngleReader() {
    _instance ??= UdpAngleReader._internal();
    return _instance!;
  }

  UdpAngleReader._internal() {
    _angleStreamController = StreamController<double>.broadcast(onListen: _startSocket, onCancel: _stopSocket);
  }

  void _startSocket() async {
    _udpSocket ??= await RawDatagramSocket.bind(InternetAddress.loopbackIPv4, 5001);
    _udpSocket!.listen((event) {
      // Фільтруємо тут через if
      if (event == RawSocketEvent.read) {
        final datagram = _udpSocket!.receive();

        if (datagram != null) {
          final message = utf8.decode(datagram.data);

          try {
            final angle = double.parse(message);
            _angleStreamController.add(angle);
          } catch (e) {
            print('error: $message');
          }
        }
      }
    });
  }

  void _stopSocket() async {
    _udpSocket?.close();
    _angleStreamController.close();
    _udpSocket = null;
  }
}
