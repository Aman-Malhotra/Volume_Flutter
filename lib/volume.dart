import 'dart:async';

import 'package:flutter/services.dart';

enum AudioManager {
  STREAM_VOICE_CALL,
  STREAM_SYSTEM,
  STREAM_RING,
  STREAM_MUSIC,
  STREAM_ALARM,
  STREAM_NOTIFICATION,
}

class Volume {
  static const MethodChannel _channel = const MethodChannel('volume');

  static Future<Null> controlVolume(AudioManager audioManager) async {
    Map<String, int> map = <String, int>{};
    map.putIfAbsent("streamType", () {
      return getInt(audioManager);
    });
    await _channel.invokeMethod('controlVolume', map);
    return null;
  }

  static Future<int> get  getMaxVol async {
    int maxVol = await _channel.invokeMethod('getMaxVol');
    return maxVol;
  }

  static Future<int> get getVol async {
    int vol = await _channel.invokeMethod('getVol');
    return vol;
  }
  static Future<int> setVol(int i) async {
    Map<String, int> map = <String, int>{};
    map.putIfAbsent("newVol", () {
      print(i);
      return i;
    });
    int vol = await _channel.invokeMethod('setVol', map);
    return vol;
  }
}

int getInt(AudioManager audioManager) {
  switch (audioManager) {
    case AudioManager.STREAM_VOICE_CALL:
      return 0;
    case AudioManager.STREAM_SYSTEM:
      return 1;
    case AudioManager.STREAM_RING:
      return 2;
    case AudioManager.STREAM_MUSIC:
      return 3;
    case AudioManager.STREAM_ALARM:
      return 4;
    case AudioManager.STREAM_NOTIFICATION:
      return 5;
    default:
      return null;
  }
}
