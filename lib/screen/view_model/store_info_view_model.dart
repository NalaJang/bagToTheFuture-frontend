import 'package:flutter/material.dart';

class StoreInfoViewModel with ChangeNotifier {
  bool _isDialogOpen = false;
  int _totalPrice = 0;

  bool get isDialogOpen => _isDialogOpen;
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

  openDialog() {
    _isDialogOpen = true;
    notifyListeners();
  }

  closeDialog() {
    _isDialogOpen = false;
    notifyListeners();
  }
}
