import 'package:flutter/material.dart';

class StoreInfoViewModel with ChangeNotifier {
  int _totalPrice = 0;

  int get totalPrice => _totalPrice;

  resetTotalPrice(int price) {
    _totalPrice = 0;
    notifyListeners();
  }

  addTotalPrice(int price) {
    _totalPrice += price;
    notifyListeners();
  }

  minusTotalPrice(int price) {
    _totalPrice -= price;
    notifyListeners();
  }
}
