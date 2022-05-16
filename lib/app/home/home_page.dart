import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/home/home_view_model.dart';
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
                SizedBox(
                  width: 100,
                  height: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: CircleBorder(),
                    ),
                    onPressed: () {
                      print('食費を入力');
                      showCupertinoDialog<void>(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: Text("朝食"),
                            content: Column(
                              children: [
                                SizedBox(
                                  width: 2,
                                  height: 2,
                                ),
                                Text('金額を入力してください'),
                                SizedBox(
                                  width: 18,
                                  height: 18,
                                ),
                                CupertinoTextField(
                                  controller: viewModel.foodPriceController,
                                  autofocus: true,
                                  keyboardType: TextInputType.number,
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'キャンセル',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  final expenditureDate =
                                      await viewModel.createExpenditureDate(
                                    viewModel.selectYear,
                                    viewModel.selectMonth,
                                    viewModel.selectDay,
                                  );
                                  print('返り血$expenditureDate');
                                  final foodPrice = int.parse(
                                      viewModel.foodPriceController.text);
                                  print('食費の金額: $foodPrice');
                                  await viewModel.createRecord(
                                    foodPrice,
                                    expenditureDate,
                                  );
                                  viewModel.foodPriceController.clear();
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  '完了',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      '朝食',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 18,
                  height: 18,
                ),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: CircleBorder(),
                    ),
                    onPressed: () {
                      print('食費を入力');
                    },
                    child: Text(
                      '昼食',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 18,
                  height: 18,
                ),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: CircleBorder(),
                    ),
                    onPressed: () {
                      print('食費を入力');
                    },
                    child: Text(
                      '夕食',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
