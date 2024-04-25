import 'package:daum_postcode_search/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:rest_api_ex/design/color_styles.dart';
import 'package:rest_api_ex/design/font_styles.dart';

class DaumPostcodeScreen extends StatelessWidget {
  const DaumPostcodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(
            '주소 검색',
            style: FontStyles.Title3.copyWith(color: AppColors.black),
          ),
          centerTitle: true,
        ),
        body: DaumPostcodeSearch(
          webPageTitle: '도로명 주소 검색',
          initialOption: InAppWebViewGroupOptions(),
          onConsoleMessage: ((controller, consoleMessage) {}),
          onLoadError: ((controller, url, code, message) {}),
          onLoadHttpError: ((controller, url, statusCode, description) {}),
          onProgressChanged: ((controller, progress) {}),
          androidOnPermissionRequest: (controller, origin, resources) async {
            return PermissionRequestResponse(
                resources: resources,
                action: PermissionRequestResponseAction.GRANT
            );
          },
        )
    );
  }
}