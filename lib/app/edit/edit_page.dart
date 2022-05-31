import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/edit/date_picker.dart';
import 'package:food_record/app/edit/edit_view_model.dart';
import 'package:food_record/app/edit/input_dialog.dart';
import 'package:food_record/app/record/record_model.dart';

class EditPage extends ConsumerWidget {
  const EditPage({
    Key? key,
    required this.record,
  }) : super(key: key);

  final RecordModel record;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(editViewModelProvider);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          '${record.category}(${record.expenditureDate.year}/${record.expenditureDate.month}/${record.expenditureDate.day})',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
              bottom: 8,
              left: 16,
            ),
            child: Text(
              'カテゴリー',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            tileColor: Colors.white,
            title: Text(
              record.category,
            ),
            trailing: Icon(
              Icons.arrow_back_ios,
              textDirection: TextDirection.rtl,
            ),
          ),
          // Text(record.category),
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
              bottom: 8,
              left: 16,
            ),
            child: Text(
              '金額',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Text('金額'),
          ListTile(
            tileColor: Colors.white,
            title: Text(
              viewModel.money == 0 ? '${record.money}円' : '${viewModel.money}円',
            ),
            trailing: Icon(
              Icons.arrow_back_ios,
              textDirection: TextDirection.rtl,
            ),
            onTap: () {
              showCupertinoDialog<void>(
                context: context,
                builder: (context) {
                  return InputDialog(
                    category: record.category,
                    viewModel: viewModel,
                  );
                },
              );
            },
          ),
          // Text('${record.money}円'),
          // Text('日付'),
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
              bottom: 8,
              left: 16,
            ),
            child: Text(
              '日付',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              showCupertinoDialog<String>(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Text('日付を選択'),
                      ),
                      content: Container(
                        width: 120,
                        height: 120,
                        child: DatePicker(
                          viewModel: viewModel,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // viewModel.foodPriceController.clear();
                            // viewModel.updateExpenditureDate();
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
                          onPressed: () {
                            print('OK');
                            viewModel.updateExpenditureDate();
                            // if (period == '開始日') {
                            //   viewModel.setOpeningDate(viewModel.openingDate);
                            // } else {
                            //   viewModel.setClosingDate(viewModel.closingDate);
                            // }
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
                      // content: Container(
                      //   height: 120,
                      //   width: 120,
                      // child: DatePicker(),
                      // ),
                    );
                  });
            },
            tileColor: Colors.white,
            title: Text(
              // '${record.expenditureDate.year}/${record.expenditureDate.month}/${record.expenditureDate.day}',
              '${viewModel.date.year}/${viewModel.date.month}/${viewModel.date.day}',
            ),
            trailing: Icon(
              Icons.arrow_back_ios,
              textDirection: TextDirection.rtl,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
            ),
            child: Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                child: Text(
                  '変更を反映させる',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute<ReportModel>(
                  //     builder: (context) => CustomPage(),
                  //   ),
                  // ).then((value) => {
                  //       viewModel.recordIndex = 3,
                  //       viewModel.loadCustomPeriod(),
                  //     });
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  elevation: 0,
                  minimumSize: Size(300, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(36),
                  ),
                ),
              ),
            ),
          ),
          // Text(
          //     '${record.expenditureDate.year}/${record.expenditureDate.month}/${record.expenditureDate.day}'),
        ],
      ),
    );
  }
}
