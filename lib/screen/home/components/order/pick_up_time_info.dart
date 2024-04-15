import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rest_api_ex/config/common/sized_box_values.dart';

class PickUpTimeInfo extends StatefulWidget {
  const PickUpTimeInfo({super.key});

  @override
  State<PickUpTimeInfo> createState() => _PickUpTimeInfoState();
}

class _PickUpTimeInfoState extends State<PickUpTimeInfo> {
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // 픽업 희망 시간 안내
          pickUpTimeInformation(),

          // 픽업 시간 선택
          timePickerSpinner()
        ],
      ),
    );
  }

  // 픽업 희망 시간 안내
  Widget pickUpTimeInformation() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '픽업 희망 시간',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        SizedBoxValues.gapH5,
        Row(
          children: [
            Text(
              '오후 8:00 ~ 오후 8:30',
              style: TextStyle(color: Colors.deepPurpleAccent),
            ),
            Text(' 사이 시간을 입력해 주세요.')
          ],
        ),
      ],
    );
  }

  // 픽업 시간 선택
  Widget timePickerSpinner() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        child: CupertinoDatePicker(
            initialDateTime: dateTime,
            mode: CupertinoDatePickerMode.time,
            onDateTimeChanged: (DateTime newTime) {
              print('$newTime');
            }),
      ),
    );
  }
}
