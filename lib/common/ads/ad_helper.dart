import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AdHelper {
  static String get bannerAdUnitId {
    const isDebug = kDebugMode;
    try {
      if (Platform.isAndroid) {
        return isDebug
            ? dotenv.env["Dev_google_ad_android_banner_key"]!
            : dotenv.env["Google_ad_android_banner_key"]!;
      } else if (Platform.isIOS) {
        return isDebug
            ? dotenv.env["Dev_google_ad_ios_banner_key"]!
            : dotenv.env["Goolge_ad_ios_banner_key"]!;
      } else {
        throw UnsupportedError('Unsupported platform');
      }
    } catch (e) {
      rethrow;
    }
  }
}
