// import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/root/root_page.dart';
import 'package:food_record/firebase_config.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:walking/api/att_helper.dart';

import 'app/home/home_page.dart';
// import 'screens/root_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseConfig().platformOptions,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// final analyticsProvider =
//     Provider<FirebaseAnalytics>((ref) => FirebaseAnalytics.instance);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance?.addPostFrameCallback(
    //   (_) => ATTHelper().attCheck(),
    // );
    // final analytics = ref.watch(analyticsProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '食費管理アプリ',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const RootPage(
          // analytics: analytics,
          ),
      navigatorObservers: [
        // FirebaseAnalyticsObserver(
        //   analytics: analytics,
        // )
      ],
    );
  }
}
