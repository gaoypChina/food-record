import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/admob/admob_api.dart';
import 'package:food_record/app/record/record_model.dart';
import 'package:food_record/app/record/record_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

final homeViewModelProvider = ChangeNotifierProvider((ref) {
  return HomeViewModel(
    ref.watch(recordServiceProvider),
  );
});

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._recordService) {
    load();
    createInterstitialAd();
  }
  final RecordService _recordService;
  // List<RecordModel> rooms = [];
  List<String> categories = [
    '朝食',
    '昼食',
    '夕食',
    'おやつ',
    '飲み物',
    '食材',
    '交際費',
    'カフェ',
  ];
  final TextEditingController foodPriceController = TextEditingController();
  static DateTime today = DateTime.now();
  int selectYear = today.year;
  int selectMonth = today.month;
  int selectDay = today.day;
  static const categoryListPrefsKey = 'categoryArray';
  static const appReviewPrefsKey = 'isReviewed';
  InterstitialAd? _interstitialAd;

  // Future<void> load() async {
  // rooms = await fetchRoom();
  // await fetchRoom();
  // print(rooms);
  // notifyListeners();
  // }

  Future<void> load() async {
    final readingCategories = await getCategories();
    if (readingCategories != null) {
      categories = readingCategories;
      // print('保存されているcategoriesを読み込んだよ〜〜〜$categories');
    } else {
      // print('まだ、SharedPreferenceは使われてはいないよ〜〜〜$categories');
    }
    notifyListeners();
  }

  Future<void> setIsReview(bool isReviewed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(appReviewPrefsKey, isReviewed);
  }

  Future<bool?> getIsReviewed() async {
    final prefs = await SharedPreferences.getInstance();
    final isReviewed = prefs.getBool(appReviewPrefsKey);
    return isReviewed;
  }

  Future<List<String>?> getCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final categoryList = prefs.getStringList(categoryListPrefsKey);
    // print('カテゴリーはjson型？？？$categoryList');
    return categoryList;
  }

  Future<int> getCategoryIndex() async {
    final categoryIndex = await _recordService.getCategoryIndex();
    return categoryIndex;
  }

  // Future<List<RecordModel>> fetchRoom() async {
  Future<void> createRecord(
    int money,
    DateTime expenditureDate,
    String category,
  ) async {
    // return _recordService.fetchRooms();
    await _recordService.createRecord(
      money,
      expenditureDate,
      category,
    );
  }

  Future<DateTime> createExpenditureDate(int year, int month, int day) async {
    final expenditureDate = DateTime(year, month, day);
    // print('支出日: $expenditureDate');
    return expenditureDate;
  }

  Future<void> getTaxIncludePrice(double number) async {
    if (foodPriceController.text.isEmpty == false) {
      final foodPrice = int.parse(foodPriceController.text) * number;
      final floorFoodPrice = foodPrice.round();
      // print(foodPrice);
      // print(floorFoodPrice);
      foodPriceController.text = floorFoodPrice.toString();
    }
  }

  void createInterstitialAd() {
    print('広告読み込むよ＝＝');
    // final myInterstitial = InterstitialAd.load(
    InterstitialAd.load(
      adUnitId: getTestAdInterstitialUnitId(),
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          // Keep a reference to the ad so you can show it later.
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  void showInterstitialAd() {
    // _createInterstitialAd();
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }
}
