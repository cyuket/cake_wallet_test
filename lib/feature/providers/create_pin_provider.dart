import 'package:cake_wallet_test/feature/widgets/dialog_alert.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreatePinProvider extends ChangeNotifier {
  final _pins = <int>[];
  List<int> get pins => _pins;
  bool _confirmPin = false;
  bool get confirmPin => _confirmPin;
  bool _isSixCode = false;
  bool get isSixCode => _isSixCode;
  void setIsSixCode() async {
    _isSixCode = !_isSixCode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(
      'isSixCode',
      _isSixCode,
    );
    notifyListeners();
  }

  var _pin = '';

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
        if (_confirmPin) {
          _pin == newPin
              ? await savePin()
              : await showAlertDialog('Pin Mismatch');
        } else {
          _pin = newPin;
          _confirmPin = !_confirmPin;
          notifyListeners();
        }
        reset();
      }
    }
  }

  Future<void> savePin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
      'new_pin',
      _pin,
    );

    await showAlertDialog('Your PIN has been setup successfully',
        success: true);
  }
}
