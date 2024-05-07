import 'package:flutter/cupertino.dart';

class EditMyProfileViewModel with ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  final int _nameMaxLength = 15;
  bool _showSpinner = false;

  get formKey => _formKey;

  int get nameMaxLength => _nameMaxLength;

  bool get showSpinner => _showSpinner;
}
