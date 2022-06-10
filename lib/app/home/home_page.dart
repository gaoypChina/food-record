import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/category/category_model.dart';
import 'package:food_record/app/edit_category/edit_category_page.dart';
import 'package:food_record/app/home/date_picker.dart';
import 'package:food_record/app/home/home_view_model.dart';
import 'package:food_record/app/home/mini_record_button.dart';
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
      body: SingleChildScrollView(
        child: Container(
          height: 540,
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
              DatePicker(viewModel: viewModel),
              Padding(
                padding: const EdgeInsets.only(
                  right: 8,
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<CategoryModel>(
                          builder: (context) => EditCategoryPage(),
                        ),
                      ).then((value) => {
                            // print('EditCategoryから戻ってきたよ: $value'),
                            viewModel.load(),
                          });
                      // .then((value) => {
                      //       viewModel.recordIndex = 3,
                      //       viewModel.loadCustomPeriod(),
                      //     });
                    },
                    style: OutlinedButton.styleFrom(
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: const BorderSide(
                        color: Colors.green,
                      ),
                    ),
                    child: Text(
                      'カテゴリーを編集',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RecordButton(
                    viewModel: viewModel,
                    category: viewModel.categories[0],
                    // category: '朝食',
                  ),
                  SizedBox(
                    width: 18,
                    height: 18,
                  ),
                  RecordButton(
                    viewModel: viewModel,
                    category: viewModel.categories[1],
                    // category: '昼食',
                  ),
                  SizedBox(
                    width: 18,
                    height: 18,
                  ),
                  RecordButton(
                    viewModel: viewModel,
                    category: viewModel.categories[2],
                    // category: '夕食',
                  )
                ],
              ),
              Flexible(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: viewModel.categories.sublist(3).length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        MiniRecordButton(
                          viewModel: viewModel,
                          category: viewModel.categories.sublist(3)[index],
                          // category: '朝食',
                        ),
                        SizedBox(
                          width: 12,
                          height: 12,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class DatePicker extends StatelessWidget {
//   const DatePicker({
//     Key? key,
//     required this.viewModel,
//   }) : super(key: key);

//   final HomeViewModel viewModel;

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Row(
//         children: [
//           Expanded(
//             // height: MediaQuery.of(context).size.height / 3,
//             child: CupertinoPicker(
//               itemExtent: 30,
//               children: Constants.yearArray
//                   .map((year) => Text(year.toString() + '年'))
//                   .toList(),
//               scrollController: FixedExtentScrollController(
//                 initialItem: 1,
//               ),
//               onSelectedItemChanged: (index) {
//                 print(index);
//                 viewModel.selectYear = Constants.yearArray[index];
//                 print(viewModel.selectYear);
//               },
//             ),
//           ),
//           Expanded(
//             // height: MediaQuery.of(context).size.height / 3,
//             child: CupertinoPicker(
//               looping: true,
//               itemExtent: 30,
//               children: Constants.monthArray
//                   .map((month) => Text(month.toString() + '月'))
//                   .toList(),
//               scrollController: FixedExtentScrollController(
//                 initialItem:
//                     viewModel.selectMonth == 1 ? 0 : viewModel.selectMonth - 1,
//               ),
//               onSelectedItemChanged: (index) {
//                 print(index);
//                 viewModel.selectMonth = Constants.monthArray[index];
//                 print(viewModel.selectMonth);
//               },
//             ),
//           ),
//           Expanded(
//             // height: MediaQuery.of(context).size.height / 3,
//             child: CupertinoPicker(
//               looping: true,
//               itemExtent: 30,
//               children: Constants.dayArray
//                   .map((day) => Text(day.toString() + '日'))
//                   .toList(),
//               scrollController: FixedExtentScrollController(
//                 initialItem:
//                     viewModel.selectDay == 1 ? 0 : viewModel.selectDay - 1,
//               ),
//               onSelectedItemChanged: (index) {
//                 print(index);
//                 viewModel.selectDay = Constants.dayArray[index];
//                 print(viewModel.selectDay);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
