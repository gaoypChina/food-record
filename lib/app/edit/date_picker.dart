import 'package:flutter/cupertino.dart';
import 'package:food_record/app/edit/edit_view_model.dart';
import 'package:food_record/app/home/home_view_model.dart';
import 'package:food_record/constants.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final EditViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          // height: MediaQuery.of(context).size.height / 3,
          child: CupertinoPicker(
            itemExtent: 30,
            children: Constants.yearArray
                .map((year) => Text(year.toString() + '年'))
                .toList(),
            scrollController: FixedExtentScrollController(
              initialItem: 8,
            ),
            onSelectedItemChanged: (index) {
              print(index);
              viewModel.selectYear = Constants.yearArray[index];
              print(viewModel.selectYear);
            },
          ),
        ),
        Expanded(
          // height: MediaQuery.of(context).size.height / 3,
          child: CupertinoPicker(
            looping: true,
            itemExtent: 30,
            children: Constants.monthArray
                .map((month) => Text(month.toString() + '月'))
                .toList(),
            scrollController: FixedExtentScrollController(
              initialItem:
                  viewModel.selectMonth == 1 ? 0 : viewModel.selectMonth - 1,
            ),
            onSelectedItemChanged: (index) {
              print(index);
              viewModel.selectMonth = Constants.monthArray[index];
              print(viewModel.selectMonth);
            },
          ),
        ),
        Expanded(
          // height: MediaQuery.of(context).size.height / 3,
          child: CupertinoPicker(
            looping: true,
            itemExtent: 30,
            children: Constants.dayArray
                .map((day) => Text(day.toString() + '日'))
                .toList(),
            scrollController: FixedExtentScrollController(
              initialItem:
                  viewModel.selectDay == 1 ? 0 : viewModel.selectDay - 1,
            ),
            onSelectedItemChanged: (index) {
              print(index);
              viewModel.selectDay = Constants.dayArray[index];
              print(viewModel.selectDay);
            },
          ),
        ),
      ],
    );
  }
}
