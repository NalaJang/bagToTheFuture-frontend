import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rest_api_ex/config/constants.dart';
import 'package:rest_api_ex/config/validation_check.dart';
import 'package:rest_api_ex/config/user_info_text_form_field.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';
import 'package:rest_api_ex/design/svg_icon.dart';

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
  // String? _selectedBank;
  List<String> _selectedBanks = ['우리은행', '하나은행', '신한은행', '카카오'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 이메일
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '이메일',
              style: FontStyles.Body2.copyWith(color: AppColors.black),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 21.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: widget.userEmail,
                  labelStyle: FontStyles.Body2,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: const BorderSide(color: AppColors.gray4),
                  ),
                ),
              ),
            ),
          ],
        ),

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

        // 생년월일
        _buildTextFormField(
          label: Constants.birth,
          isNecessary: false,
          userInfoTextFormField: UserInfoTextFormField(
            controller: widget.userBirthController,
            validator: validateNickName,
            decorationLabelText: Constants.birthInputPrompt,
          ),
        ),

        // 환불정보
        Row(
          children: [
            Text(
              '환불정보',
              style: FontStyles.Body2.copyWith(color: AppColors.black),
            ),
            const Text(
              Constants.asterisk,
              style: TextStyle(color: AppColors.red),
            ),
          ],
        ),

        _buildBankInfo(),
        _buildAccountTextField(),
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

  Widget _buildBankInfo() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 16),
      child: Row(
        children: [
          _buildBankDropdown(),
          _buildAccountHolderTextField(),
        ],
      ),
    );
  }

  Widget _buildBankDropdown() {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: DropdownMenu(
        hintText: '은행명',
        width: MediaQuery.of(context).size.width * 0.4,
        dropdownMenuEntries: _selectedBanks
            .map((e) => DropdownMenuEntry<String>(value: e, label: e))
            .toList(),
        menuStyle: const MenuStyle(
          alignment: Alignment.bottomLeft,
          backgroundColor: MaterialStatePropertyAll<Color>(AppColors.white),
        ),
        trailingIcon: SvgIcon.downArrow(),
        selectedTrailingIcon: SvgIcon.downArrow(),
      ),
    );
  }

  Widget _buildAccountHolderTextField() {
    return Expanded(
      child: TextFormField(
        controller: widget.accountHolderController,
        validator: validateConfirmAccountHolder,
        decoration: InputDecoration(
          labelText: Constants.accountHolderInputPrompt,
          labelStyle: FontStyles.Body2.copyWith(color: AppColors.gray4),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 10,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.main,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.main,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAccountTextField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 41),
      child: UserInfoTextFormField(
        controller: widget.accountController,
        validator: validateConfirmAccount,
        decorationLabelText: Constants.accountInputPrompt,
      ),
    );
  }
}
