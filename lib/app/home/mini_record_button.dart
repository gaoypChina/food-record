import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_record/app/home/home_view_model.dart';
import 'package:food_record/app/home/input_dialog.dart';

class MiniRecordButton extends StatelessWidget {
  const MiniRecordButton({
    Key? key,
    required this.viewModel,
    required this.category,
  }) : super(key: key);

  final HomeViewModel viewModel;
  final String category;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 64,
      child: MaterialButton(
        // style: OutlinedButton.styleFrom(
        // primary: Colors.blue,
        shape: const CircleBorder(
          side: BorderSide(
            color: Colors.blue,
          ),
        ),
        elevation: 0,
        // ),
        onPressed: () {
          // print('食費を入力');
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
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
