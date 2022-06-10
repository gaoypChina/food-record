import 'package:flutter/cupertino.dart';
import 'package:food_record/app/custom/custom_view_model.dart';
import 'package:food_record/constants.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({
    Key? key,
    required this.viewModel,
    required this.isOpening,
  }) : super(key: key);

  final CustomViewModel viewModel;
  final bool isOpening;

  @override
  Widget build(BuildContext context) {
    final date =
        isOpening == true ? viewModel.openingDate : viewModel.closingDate;
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
              // print(index);
              if (isOpening == true) {
                final opening = DateTime(
                  Constants.yearArray[index],
                  viewModel.openingDate.month,
                  viewModel.openingDate.day,
                );
                viewModel.openingDate = opening;
                // print(viewModel.openingDate);
              } else {
                final closing = DateTime(
                  Constants.yearArray[index],
                  viewModel.closingDate.month,
                  viewModel.closingDate.day,
                );
                viewModel.closingDate = closing;
                // print(viewModel.closingDate);
              }
              // viewModel.selectYear = Constants.yearArray[index];
              // print(viewModel.selectYear);
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
              initialItem: date.month == 1 ? 0 : date.month - 1,
              // initialItem:
              //     viewModel.selectMonth == 1 ? 0 : viewModel.selectMonth - 1,
            ),
            onSelectedItemChanged: (index) {
              // print(index);
              if (isOpening == true) {
                final opening = DateTime(
                  viewModel.openingDate.year,
                  Constants.monthArray[index],
                  viewModel.openingDate.day,
                );
                viewModel.openingDate = opening;
                // print(viewModel.openingDate);
              } else {
                final closing = DateTime(
                  viewModel.closingDate.year,
                  Constants.monthArray[index],
                  viewModel.closingDate.day,
                );
                viewModel.closingDate = closing;
                // print(viewModel.closingDate);
              }
              // viewModel.selectMonth = Constants.monthArray[index];
              // print(viewModel.selectMonth);
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
              initialItem: date.day == 1 ? 0 : date.day - 1,
              // initialItem:
              //     viewModel.selectDay == 1 ? 0 : viewModel.selectDay - 1,
            ),
            onSelectedItemChanged: (index) {
              // print(index);
              if (isOpening == true) {
                final opening = DateTime(
                  viewModel.openingDate.year,
                  viewModel.openingDate.month,
                  Constants.dayArray[index],
                );
                viewModel.openingDate = opening;
                // print(viewModel.openingDate);
              } else {
                final closing = DateTime(
                  viewModel.closingDate.year,
                  viewModel.closingDate.month,
                  Constants.dayArray[index],
                );
                viewModel.closingDate = closing;
                // print(viewModel.closingDate);
              }
              // viewModel.selectDay = Constants.dayArray[index];
              // print(viewModel.selectDay);
            },
          ),
        ),
      ],
    );
  }
}
