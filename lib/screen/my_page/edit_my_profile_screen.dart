import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_ex/config/navigate_to.dart';
import 'package:rest_api_ex/config/validation_check.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:rest_api_ex/design/svg_icon.dart';
import 'package:rest_api_ex/screen/my_page/refund_info_screen.dart';
import 'package:rest_api_ex/screen/view_model/edit_my_profile_view_model.dart';

class EditMyProfileScreen extends StatefulWidget {
  const EditMyProfileScreen({super.key});

  @override
  State<EditMyProfileScreen> createState() => _EditMyProfileScreenState();
}

class _EditMyProfileScreenState extends State<EditMyProfileScreen> {
  final _userNicknameController = TextEditingController(text: '김창영');
  String nameValue = '';

  @override
  void initState() {
    super.initState();
    nameValue = _userNicknameController.text;
  }

  @override
  void dispose() {
    _userNicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<EditMyProfileViewModel>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgIcon.arrowLeft(color: AppColors.black),
          onPressed: () {

            // ValidationCheck().allUserInputValidation(viewModel.formKey);

            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          '프로필 편집',
          style: FontStyles.Title3.copyWith(color: AppColors.black),
        ),
        backgroundColor: AppColors.white,
      ),

      body: ModalProgressHUD(
        inAsyncCall: viewModel.showSpinner,
        child: Form(
          key: viewModel.formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 0),
            child: Column(
              children: [
                _nameField(viewModel),
                _refundField(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _nameField(EditMyProfileViewModel viewModel) {
    return TextFormField(
      controller: _userNicknameController,
      validator: validateNickName,
      maxLength: viewModel.nameMaxLength,
      decoration: InputDecoration(
        counterText: '',
        suffix: Container(
          margin: const EdgeInsets.only(right: 5),
          child: Text(
            '${nameValue.length}/${viewModel.nameMaxLength}자',
            style: FontStyles.Body8.copyWith(color: AppColors.gray4),
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.gray4),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.main),
        ),
      ),
      onChanged: (value) {
        setState(() {
          nameValue = value;
        });
      },
    );
  }

  Widget _refundField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(3.5, 66, 3.5, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '환불 정보',
            style: FontStyles.Body2.copyWith(color: AppColors.black),
          ),
          GestureDetector(
            onTap: () => navigateTo(context, const RefundInfoScreen()),
            child: Row(
              children: [
                Text(
                  '3020735977861',
                  style: FontStyles.Body6.copyWith(
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(width: 7),
                SvgIcon.arrowRight(
                  width: 16,
                  height: 16,
                  color: AppColors.gray4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
