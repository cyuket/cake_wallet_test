import 'package:cake_wallet_test/feature/widgets/dialog_alert.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticatePinProvider extends ChangeNotifier {
  final _pins = <int>[];
  List<int> get pins => _pins;

  bool _isSixCode = false;
  bool get isSixCode => _isSixCode;

  String? _pin = '';
  void initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _pin = prefs.getString('new_pin');
    _isSixCode = prefs.getBool('isSixCode') ?? false;
    notifyListeners();
  }

  void reset() {
    _pins.clear();

    notifyListeners();
  }

  int zeroKeyPressed(int i) {
    if (i == 10) {
      return 0;
    } else {
      return i + 1;
    }
  }

  void keysPressed(int i) async {
    if (i == 9) return;
    if (i == 11) {
      if (_pins.isNotEmpty) {
        _pins.removeLast();
        notifyListeners();
      }
    } else {
      var length = isSixCode ? 6 : 4;
      if (_pins.length < length) {
        _pins.add(zeroKeyPressed(i));
        notifyListeners();
      }
      if (_pins.length == length) {
        var newPin = '';
        for (var item in _pins) {
          newPin += item.toString();
        }

        if (newPin == _pin) {
          await showAlertDialog('Authentication success', hideButton: true);
        } else {
          await showAlertDialog(
            'Authentication failed',
            hideButton: true,
          );
        }
        reset();
      }
    }
  }
}
