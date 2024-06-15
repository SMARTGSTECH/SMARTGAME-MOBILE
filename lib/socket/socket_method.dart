import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/socket/provider.dart';
import 'package:smartbet/socket/socket_client.dart';

class SocketMethods {
  final _socket = SocketClient.instance.socket!;

  Map eventListeners = {
    "count_down": "counter",
    "output": "result",
    "history": "latesthistory",
    "coins": "coincompare",
    'init_value': "gamestart"
  };

  void counterEvent(BuildContext context) {
    _socket.on(eventListeners["count_down"], (data) {
      print(data["value"]);
      final socketInstance =
          Provider.of<SocketProvider>(context, listen: false);
      socketInstance.setCounter(data["value"]);
    });
  }

  void initialVal(BuildContext context) {
    // _socket.on(eventListeners["init_value"], (data) {
    //   print('this is the initial value' + data["value"]);
    //   // final socketInstance =
    //   //     Provider.of<SocketProvider>(context, listen: false);
    //   // socketInstance.setCoin(data["value"]);
    // });
  }

  void priceEvent(BuildContext context) {
    _socket.on(eventListeners["coins"], (data) {
      // print(data["value"]);
      final socketInstance =
          Provider.of<SocketProvider>(context, listen: false);
      socketInstance.setCoin(data["value"]);
    });
  }

  void resultEvent(BuildContext context) {
    _socket.on(eventListeners["output"], (data) {
      print(data["data"]);
      final socketInstance =
          Provider.of<SocketProvider>(context, listen: false);
      socketInstance.setGameOutput(data["data"]);
    });
  }

  void resultHistory(BuildContext context) {
    _socket.on(eventListeners["history"], (data) {
      print(data["data"]);
      final socketInstance =
          Provider.of<SocketProvider>(context, listen: false);
      socketInstance.setGameHistory(data["data"]);
    });
  }
}
