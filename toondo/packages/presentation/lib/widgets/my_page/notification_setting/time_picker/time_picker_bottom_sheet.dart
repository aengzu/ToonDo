import 'package:flutter/material.dart';
import 'package:presentation/viewmodels/my_page/notification_setting/time_picker_viewmodel.dart';
import 'package:presentation/widgets/bottom_sheet/custom_bottom_sheet.dart';
import 'package:presentation/widgets/my_page/notification_setting/time_picker/time_picker_column.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:presentation/viewmodels/my_page/notification_setting/time_picker_viewmodel.dart';
import 'package:presentation/widgets/bottom_sheet/custom_bottom_sheet.dart';
import 'package:presentation/widgets/my_page/notification_setting/time_picker/time_picker_column.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:presentation/viewmodels/my_page/notification_setting/time_picker_viewmodel.dart';
import 'package:presentation/widgets/bottom_sheet/custom_bottom_sheet.dart';
import 'package:presentation/widgets/my_page/notification_setting/time_picker/time_picker_column.dart';
import 'package:provider/provider.dart';

class TimePickerBottomSheet extends StatelessWidget {
  const TimePickerBottomSheet({super.key});

  static List<String> get _hourItems =>
      List.generate(12, (index) => '${index + 1}');

  static List<String> get _minuteItems =>
      List.generate(60, (index) => index.toString().padLeft(2, '0'));

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TimePickerViewModel>();

    return CustomBottomSheet(
      title: '시간 설정',
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TimePickerColumn(
            items: ['오전', '오후'],
            initialItem: viewModel.ampm,
            onItemSelected: viewModel.setAmPm,
          ),
          const SizedBox(width: 8),
          TimePickerColumn(
            items: _hourItems,
            initialItem: int.parse(viewModel.hour).toString(),
            onItemSelected: viewModel.setHour,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              ':',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1C1D1B),
              ),
            ),
          ),
          TimePickerColumn(
            items: _minuteItems,
            initialItem: viewModel.minute,
            onItemSelected: viewModel.setMinute,
          ),
        ],
      ),
      buttons: [
        CommonBottomSheetButtonData(
          label: '저장하기',
          filled: false,
          onPressed: () async {
            await viewModel.saveSelectedTime();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
