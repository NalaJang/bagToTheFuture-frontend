import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rest_api_ex/config/common/sized_box_values.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:rest_api_ex/design/svg_icon.dart';

class WriteReviewScreen extends StatefulWidget {
  const WriteReviewScreen({super.key});

  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  int starRate = 0;
  String? _imagePath;
  TextEditingController textController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource imageSource, BuildContext context) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: SvgIcon.backButton(
                color: AppColors.black, width: 14, height: 14),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text(
            '별점 및 리뷰',
            style: FontStyles.Title3.copyWith(color: AppColors.black),
          ),
          backgroundColor: AppColors.white,
        ),
        backgroundColor: AppColors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 41, 30, 50),
              child: Column(
                children: [
                  const Text('참바른빵', style: FontStyles.Title5),
                  const Text('에서의 주문은 어떠셨나요?', style: FontStyles.Body2),
                  SizedBoxValues.gapH10,
                  _starRate(),
                  const SizedBox(height: 30),
                  _inputReview(),
                  SizedBoxValues.gapH15,
                  _addPicture(context),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(17, 0, 15, 31),
                child: _submitButton(),
              ),
            )
          ],
        ),
      ),
    );
  }

  // 별점 로직
  Row _starRate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 1; i <= 10; i++) ...[
          Transform.translate(
            offset: i % 2 == 0 ? const Offset(-0.4, 0) : const Offset(0, 0),
            child: Container(
              margin: i % 2 == 0 ? const EdgeInsets.only(right: 5) : null,
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (starRate == 1 && i == 1) {
                        starRate = 0;
                        return;
                      }
                      starRate = i;
                    });
                  },
                  child: i % 2 == 1
                      ? SvgIcon.reviewLeftStar(
                          height: 35,
                          color: i <= starRate
                              ? AppColors.yellow
                              : AppColors.gray4)
                      : SvgIcon.reviewRightStar(
                          height: 35,
                          color: i <= starRate
                              ? AppColors.yellow
                              : AppColors.gray4)),
            ),
          ),
        ],
      ],
    );
  }

  // 리뷰 쓰기 로직
  SizedBox _inputReview() {
    return SizedBox(
      height: 212,
      child: TextField(
        textAlignVertical: TextAlignVertical.top,
        controller: textController,
        expands: true,
        maxLines: null,
        decoration: const InputDecoration(
          hintText: '리뷰를 남겨주세요',
          hintStyle: TextStyle(color: AppColors.gray4),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: AppColors.gray3,
            width: 1.0,
          )),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: AppColors.gray3,
            width: 1.0,
          )),
        ),
      ),
    );
  }

  // 사진 추가 로직
  Row _addPicture(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      GestureDetector(
        onTap: () {
          _showModalBottomSheet(context);
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.gray3, width: 1)),
          child: SizedBox(
            width: 68,
            height: 68,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgIcon.camera(width: 30, height: 30),
                SizedBoxValues.gapH5,
                const Text(
                  '사진 추가',
                  style: TextStyle(color: AppColors.gray5, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBoxValues.gapW15,
      if (_imagePath != null)
        Stack(children: [
          Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(_imagePath!),
                  fit: BoxFit.cover,
                ),
              ),
              child: const SizedBox(
                width: 68,
                height: 68,
              )),
          Positioned(
            top: 5,
            right: 5,
            child: GestureDetector(
              onTap: () => setState(() {
                _imagePath = null;
              }),
              child: SvgIcon.closeButton(width: 21, height: 21),
            ),
          ),
        ]),
    ]);
  }

  // 리뷰 등록 로직
  Column _submitButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: starRate == 0 ? AppColors.gray4 : AppColors.main,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: () {},
          child: const Padding(
            padding: EdgeInsets.all(17),
            child: Center(child: Text('등록', style: FontStyles.Body1)),
          ),
        ),
      ],
    );
  }

  // 바텀 모달 로직
  Future<dynamic> _showModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.85,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 24, top: 33),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: SvgIcon.backButton(
                        color: AppColors.black, width: 14, height: 14),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 47, top: 34),
                child: Column(
                  children: [
                    _modalMenu(
                      context,
                      SvgIcon.camera(
                          color: AppColors.black, width: 30, height: 30),
                      '카메라',
                      ImageSource.camera,
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    _modalMenu(
                      context,
                      SvgIcon.gallery(
                          color: AppColors.black, width: 30, height: 25),
                      '갤러리',
                      ImageSource.gallery,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }

  // 모달 메뉴
  GestureDetector _modalMenu(BuildContext context, Widget icon, String menuText,
      ImageSource imageSource) {
    return GestureDetector(
      onTap: () => getImage(imageSource, context),
      child: Container(
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 24),
            Text(
              menuText,
              style: FontStyles.Title5.copyWith(color: AppColors.black),
            )
          ],
        ),
      ),
    );
  }
}
