import 'package:bsccs/utils/constants.dart';
import 'package:bsccs/utils/custom_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CsBannerAd extends StatelessWidget {
  final AdSize adSize;

  const CsBannerAd({
    Key? key,
    this.adSize = AdSize.largeBanner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AdManagerBannerAd myBanner = AdManagerBannerAd(
      adUnitId: kReleaseMode
          ? "ca-app-pub-6290327266704759/6482894125"
          : "ca-app-pub-3940256099942544/6300978111",
      sizes: [adSize],
      request: const AdManagerAdRequest(),
      listener: AdManagerBannerAdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
      ),
    );
    myBanner.load();
    var cardBorderRadius = BorderRadius.circular(Constants.cardRadius);
    return Container(
      alignment: Alignment.center,
      // color: CustomColors.tableOddRowColor,
      width: adSize.width.toDouble(),
      height: adSize.height.toDouble(),
      decoration: BoxDecoration(
        color: CustomColors.actionColor,
        borderRadius: cardBorderRadius,
      ),
      child: AdWidget(ad: myBanner),
    );
    // return FutureBuilder(
    //   future: context.read<UsersRepo>().checkPremiumUser(),
    //   builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
    //     if (snapshot.hasData && snapshot.data == false) {
    //       myBanner.load();
    //       return Container(
    //         alignment: Alignment.center,
    //         // color: CustomColors.tableOddRowColor,
    //         width: adSize.width.toDouble(),
    //         height: adSize.height.toDouble(),
    //         child: AdWidget(ad: myBanner),
    //       );
    //     }
    //     return const SizedBox.shrink();
    //   },
    // );
  }

  static Widget resizableAdBox() {
    return LayoutBuilder(
      builder: (
        BuildContext context,
        BoxConstraints constraints,
      ) {
        return CsBannerAd(
          adSize: AdSize(
            width: constraints.maxWidth.toInt(),
            height: constraints.maxHeight.toInt(),
          ),
        );
      },
    );
  }
}

class CsInterstitialAd {
  InterstitialAd? _interstitialAd;

  CsInterstitialAd() {
    _prepareAdd();
  }

  void _prepareAdd() {

    InterstitialAd.load(
      adUnitId: kReleaseMode?"ca-app-pub-6290327266704759/6855263366":"ca-app-pub-3940256099942544/1033173712",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {},
      ),
    );
  }

  void showAdd({void Function()? onAddDismiss}) {
    _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        _interstitialAd = null;
        ad.dispose();
        onAddDismiss?.call();
        _prepareAdd();
      },
    );
    _interstitialAd?.show();
  }
}
