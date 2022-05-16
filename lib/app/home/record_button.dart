import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_record/app/home/home_view_model.dart';
import 'package:food_record/app/home/input_dialog.dart';

class RecordButton extends StatelessWidget {
  const RecordButton({
    Key? key,
    required this.viewModel,
    required this.category,
  }) : super(key: key);

  final HomeViewModel viewModel;
  final String category;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              return InputDialog(
                category: category,
                viewModel: viewModel,
              );
            },
          );
        },
        child: Text(
          category,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
