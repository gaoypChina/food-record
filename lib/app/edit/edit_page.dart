import 'package:flutter/material.dart';

class EditPage extends StatelessWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('編集'),
      ),
      body: Column(
        children: [
          Text('朝食'),
          Text('1000円'),
          Text('2022/5/29'),
        ],
      ),
    );
  }
}
