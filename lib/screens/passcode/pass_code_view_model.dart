import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartbet/main_screen/mobile.dart';
import 'package:smartbet/screens/passcode/passcode_view.dart';
import 'package:smartbet/utils/config/color.dart';

class PinEntryProvider with ChangeNotifier {
  PinEntryProvider() {
    log("object");
    initializePin();
  }

  final int pinLength = 4;
  String _pin = '';
  String _newPin = '';
  String _confirmPin = '';
  bool _isObscured = true;
  bool hasSetPin = false;
  String userPin = '';

  String get pin => _pin;
  bool get isObscured => _isObscured;

  List pinStore = [];

  void addDigit(String digit) {
    if (_pin.length < pinLength) {
      _pin += digit;
      notifyListeners();
    }
  }

  void addDigitToStore(String digit, context) {
    pinStore.add(digit);
    print(pinStore);
    _pin = '';
    if (pinStore.length == 2 && pinStore[0] != pinStore[1]) {
      pinStore = [];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Pins Dont Match!',
            style: TextStyle(color: ColorConfig.iconColor, fontSize: 15.sp),
          ),
          backgroundColor: ColorConfig.appBar,
        ),
      );
    } else {
      if (pinStore.length == 2 && pinStore[0] == pinStore[1]) {
        print("SAVING TO DB");
        storePin(val: pinStore.first).whenComplete(() {
          MainScreenMobile().launch(context);
          pinStore = [];
        });
      }
    }
    notifyListeners();
  }

  void deleteDigit() {
    if (_pin.isNotEmpty) {
      _pin = _pin.substring(0, _pin.length - 1);
      notifyListeners();
    }
  }

  bool get isPinComplete => _pin.length == pinLength;

  void toggleObscure() {
    _isObscured = !_isObscured;
    print('isObscured toggled to: $_isObscured');
    notifyListeners();
  }

  Future<void> storePin({required String val}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_pin', pinStore.first);
  }

  Future<bool> checkPin(String enteredPin) async {
    final prefs = await SharedPreferences.getInstance();
    String? storedPin = prefs.getString('user_pin');
    return storedPin == enteredPin;
  }

  void clearPin() {
    _pin = '';
    _newPin = '';
    _confirmPin = '';
    notifyListeners();
  }

  Future<void> initializePin() async {
    final prefs = await SharedPreferences.getInstance();
    //prefs.remove('user_pin');
    String? storedPin = prefs.getString('user_pin');
    log(storedPin.toString());
    if (storedPin == null) {
      log('setting status to false');
      hasSetPin = false;
    } else {
      log('setting status to true');
      hasSetPin = true;
      userPin = storedPin;
    }
    notifyListeners();
  }
}
