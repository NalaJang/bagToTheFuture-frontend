import 'package:flutter/material.dart';

import 'components/my_page_menu_widget.dart';
import 'components/my_recent_order_list.dart';
import 'components/sign_out.dart';
import 'components/user_profile/user_profile_widget.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            UserProfileWidget(),
            Divider(color: Colors.grey,),
            MyRecentOrderList(),
            Divider(color: Colors.grey,),
            MyPageMenuWidget(),
            SignOut(),
          ],
        ),
      ),
    );
  }
}
