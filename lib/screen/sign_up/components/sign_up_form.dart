import 'package:flutter/material.dart';
import 'package:rest_api_ex/config/constants.dart';
import 'package:rest_api_ex/config/validation_check.dart';
import 'package:rest_api_ex/config/user_info_text_form_field.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
    required this.formKey,
    required this.userEmail,
    required this.userPasswordController,
    required this.userPasswordConfirmController,
    required this.userNickNameController,
    required this.userBirthController,
    required this.userBank,
    required this.accountHolderController,
    required this.accountController,
  });

  final GlobalKey<FormState> formKey;
  final String userEmail;
  final TextEditingController userPasswordController;
  final TextEditingController userPasswordConfirmController;
  final TextEditingController userNickNameController;
  final TextEditingController userBirthController;
  final String userBank;
  final TextEditingController accountHolderController;
  final TextEditingController accountController;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 이메일
        _emailTextFormField(),

        // 비밀번호
        _buildTextFormField(
          label: '비밀번호',
          isNecessary: true,
          bottom: 14,
          userInfoTextFormField: UserInfoTextFormField(
            controller: widget.userPasswordController,
            validator: validatePassword,
            decorationLabelText: Constants.pwValidationRule,
          ),
        ),

        // 비밀번호 확인
        _buildTextFormField(
          label: '비밀번호 확인',
          isNecessary: true,
          bottom: 37,
          userInfoTextFormField: UserInfoTextFormField(
            controller: widget.userPasswordConfirmController,
            validator: (value) => validateConfirmPassword(
              value,
              widget.userPasswordController.text,
            ),
            decorationLabelText: Constants.pwValidationRule,
          ),
        ),

        // 닉네임
        _buildTextFormField(
          label: Constants.nickName,
          isNecessary: true,
          userInfoTextFormField: UserInfoTextFormField(
            controller: widget.userNickNameController,
            validator: validateNickName,
            decorationLabelText: Constants.nickNameInputPrompt,
          ),
        ),
      ],
    );
  }

  Widget _emailTextFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 37),
          child: Text(
            '이메일',
            style: FontStyles.Body2.copyWith(color: AppColors.black),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 21.0),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: widget.userEmail,
              labelStyle: FontStyles.Body2,
              contentPadding: const EdgeInsets.all(10),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: const BorderSide(color: AppColors.gray4),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextFormField({
    required String label,
    required bool isNecessary,
    double top = 10,
    double bottom = 21,
    required UserInfoTextFormField userInfoTextFormField,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              label,
              style: FontStyles.Body2.copyWith(color: AppColors.black),
            ),
            isNecessary
                ? const Text(Constants.asterisk,
                    style: TextStyle(color: AppColors.red))
                : const Text(''),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: top, bottom: bottom),
          child: userInfoTextFormField,
        )
      ],
    );
  }
}
