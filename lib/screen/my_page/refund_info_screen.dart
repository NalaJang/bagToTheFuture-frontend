import 'package:flutter/material.dart';
import 'package:rest_api_ex/config/custom_app_bar.dart';

class RefundInfoScreen extends StatelessWidget {
  const RefundInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '환불 정보',),
    );
  }
}
