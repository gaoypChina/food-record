import 'package:flutter/material.dart';

class NoDataAlert extends StatelessWidget {
  const NoDataAlert({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 24,
            width: 24,
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 16,
            ),
            child: Center(
              child: Text(
                '記録がありません',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 24,
            ),
            child: Center(
              child: Image.asset(
                'assets/images/help.png',
              ),
            ),
          ),
          // Center(
          //   child: SizedBox(
          //     width: 240,
          //     height: 48,
          //     child: ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //         primary: Colors.amber,
          //       ),
          //       onPressed: () async {
          //         print('テスト');
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute<ReportModel>(
          //             builder: (context) => HomePage(),
          //           ),
          //         );
          //       },
          //       child: Text(
          //         '食費を記録する',
          //         style: TextStyle(
          //           fontSize: 20,
          //           fontWeight: FontWeight.w600,
          //           color: Colors.grey.shade900,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   width: 24,
          //   height: 24,
          // ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 36,
            ),
            child: Text(
              '食費が記録されていなければ、グラフは表示されません。',
            ),
          ),
          SizedBox(
            width: 24,
            height: 24,
          ),
        ],
      ),
    );
  }
}
