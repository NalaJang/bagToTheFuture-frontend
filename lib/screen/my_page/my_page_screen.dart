import 'package:flutter/material.dart';

import 'components/my_page/menu_widget.dart';
import 'components/my_page/in_progress_order.dart';
import 'components/my_page/user_widget.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            UserWidget(),
            InProgressOrder(),
            MenuWidget(),
          ],
        ),
      ),
    );
  }
}
