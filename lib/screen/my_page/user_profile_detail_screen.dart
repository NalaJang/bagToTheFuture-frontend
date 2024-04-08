import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'components/user_profile/user_profile_image.dart';

class UserProfileDetailScreen extends StatelessWidget {
  const UserProfileDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필 설정'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            // 프로필 사진
            const UserProfileImage(),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // 사용자 이름
                  TextFormField(
                    maxLength: 15,
                    decoration: const InputDecoration(
                      hintText: '김창영',
                      hintStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  _buildUserInfoTextButton('생년월일', userInfo: '1990.08.28'),
                  _buildUserInfoTextButton('성별'),
                  _buildUserInfoTextButton('거주지'),
                  Text('연동된 소셜 계정'),
                  Divider(color: Colors.grey,),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoTextButton(String infoTitle, {String? userInfo}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(infoTitle),
        GestureDetector(
          onTap: () {
            print(infoTitle);
          },
          child: Row(
            children: [
              Text(userInfo ?? '정보 추가하기'),
              Icon(Icons.navigate_next),
            ],
          ),
        )
      ],
    );
  }
}
