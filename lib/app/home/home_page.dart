import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/home/home_view_model.dart';
import 'package:food_record/app/home/record_button.dart';
import 'package:food_record/constants.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(homeViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        title: Column(
          children: const [
            Text(
              '食費を記録する',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        height: 320,
        child: Column(
          children: [
            SizedBox(
              width: 18,
              height: 18,
            ),
            Text(
              '支出日',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            SizedBox(
              width: 18,
              height: 18,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    // height: MediaQuery.of(context).size.height / 3,
                    child: CupertinoPicker(
                      itemExtent: 30,
                      children: Constants.yearArray
                          .map((year) => Text(year.toString() + '年'))
                          .toList(),
                      scrollController: FixedExtentScrollController(
                        initialItem: 1,
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
                        initialItem: viewModel.selectMonth == 1
                            ? 0
                            : viewModel.selectMonth - 1,
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
                        initialItem: viewModel.selectDay == 1
                            ? 0
                            : viewModel.selectDay - 1,
                      ),
                      onSelectedItemChanged: (index) {
                        print(index);
                        viewModel.selectDay = Constants.dayArray[index];
                        print(viewModel.selectDay);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RecordButton(
                  viewModel: viewModel,
                  category: '朝食',
                ),
                SizedBox(
                  width: 18,
                  height: 18,
                ),
                RecordButton(
                  viewModel: viewModel,
                  category: '昼食',
                ),
                SizedBox(
                  width: 18,
                  height: 18,
                ),
                RecordButton(
                  viewModel: viewModel,
                  category: '夕食',
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
