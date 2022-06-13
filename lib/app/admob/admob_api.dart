// バナー広告をインスタンス化
import 'package:google_mobile_ads/google_mobile_ads.dart';

InterstitialAd? _interstitialAd;

BannerAd myBanner = BannerAd(
  adUnitId: getTestAdBannerUnitId(),
  size: AdSize.banner,
  request: const AdRequest(),
  listener: const BannerAdListener(),
)..load();

void createInterstitialAd() {
  // print('広告読み込むよ＝＝');
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
        // print('InterstitialAd failed to load: $error');
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

// InterstitialAd myInterstitial =
// InterstitialAd(
//   adUnitId: getTestAdInterstitialUnitId(),
//   request: const AdRequest(),
// );
// バナー広告の読み込み
// myBanner.load();

// プラットフォーム（iOS / Android）に合わせてデモ用広告IDを返す
String getTestAdBannerUnitId() {
  // const testBannerUnitId = "ca-app-pub-4934605992618285/7840208836";

  // iOSのデモ用バナー広告ID
  const testBannerUnitId = "ca-app-pub-3940256099942544/2934735716";

  return testBannerUnitId;
}

String getTestAdInterstitialUnitId() {
  // iOSのテスト用インタースティシャル広告
  const testBannerUnitId = "ca-app-pub-3940256099942544/4411468910";
  // const testBannerUnitId = "ca-app-pub-4934605992618285/2481487598";
  return testBannerUnitId;
}
