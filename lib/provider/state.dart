import 'package:flutter/material.dart';

class StateProvider extends ChangeNotifier {
  bool _isLoading = false;

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  bool getLoading() => _isLoading;
}
