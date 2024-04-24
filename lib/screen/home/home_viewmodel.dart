import 'package:flutter/cupertino.dart';

import '../../data/model/my_location_model.dart';

class HomeViewModel with ChangeNotifier {
  late List<MyLocationModel> _item = [];

  List<MyLocationModel> get items => _item;

  Future<void> addItem(String title, String description) async{
    _item.add(MyLocationModel(title: title, description: description));
    print('완료');
    notifyListeners();
  }

  Future<void> removeItem(int index) async{
    if(index >=0 && index < _item.length) {
      _item.removeAt(index);
      notifyListeners();
    }
  }
}