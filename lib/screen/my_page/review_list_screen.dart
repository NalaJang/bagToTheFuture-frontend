import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rest_api_ex/config/custom_app_bar.dart';

class ReviewListScreen extends StatelessWidget {
  const ReviewListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: CustomAppBar(
      title: '리뷰 관리',
    ));
  }
}
