import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileImage extends StatefulWidget {
  const UserProfileImage({super.key});

  @override
  State<UserProfileImage> createState() => _UserProfileImageState();
}

class _UserProfileImageState extends State<UserProfileImage> {
  XFile? _imageFile;

  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width * 0.3;

    return Column(
      children: [
        Stack(
          children: [
            Container(
              constraints: BoxConstraints(
                minWidth: imageSize,
                minHeight: imageSize,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: setImage(_imageFile, imageSize),
              ),
            ),
            Positioned(
              right: MediaQuery.of(context).size.width * 0.3,
              bottom: 10,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => bottomSheet(context)),
                  );
                },
                child: const Icon(Icons.camera_alt),
              ),
            )
          ],
        ),
      ],
    );
  }

  DecorationImage setImage(XFile? imageFile, double imageSize) {
    if (imageFile == null) {
      return const DecorationImage(
        image: AssetImage('assets/images/sample.png'),
      );
    } else {
      return DecorationImage(
        image: FileImage(File(imageFile.path)),
      );
    }
  }

  Widget bottomSheet(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // 앨범에서 사진 선택
              IconButton(
                onPressed: () {
                  _pickedImage(ImageSource.gallery);
                },
                icon: const Icon(Icons.photo_library),
              ),

              // 기본 이미지로 변경
              TextButton(
                  onPressed: () {
                    setState(() {
                      _imageFile = null;
                    });
                  },
                  child: const Text('기본 이미지로 변경'))
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _pickedImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    } else {
      if (kDebugMode) {
        print('이미지 선택 안 함');
      }
    }
  }
}
