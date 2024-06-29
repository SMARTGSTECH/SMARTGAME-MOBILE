import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReusableBottomModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, value, Widget? child) {
        return Container(
          height: 900,
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Reusable Bottom Sheet'),
                ElevatedButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
