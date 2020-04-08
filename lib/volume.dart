import 'dart:async';
import 'package:flutter/services.dart';
import 'package:system_shortcuts/system_shortcuts.dart';

/// AudioManager Streams control the type of volume the getVol and setVol fucntion will control.
enum AudioManager {
  /// Controls the Voice Call volume
  STREAM_VOICE_CALL,

  /// Controls the system volume
  STREAM_SYSTEM,

  /// Controls the ringer volume
  STREAM_RING,

  /// Controls the media volume
  STREAM_MUSIC,

  // Controls the alarm volume
  STREAM_ALARM,

  /// Controls the notification volume
  STREAM_NOTIFICATION,
}

/// You can control VoiceCall, System, Ringer, Media, Alarm, Notification
/// volume and get the max possible volumes for the respective.
/// 
/// Call the controlVolume ( AudioManager ) function in initState ()
/// 
/// to to make sure the setVol ( int ) , getMaxVol, and getVol control
/// 
/// the volume passed as the parameter to the controlVolume ( AudioManager ) 
/// function.
class Volume {
  static const MethodChannel _channel = const MethodChannel('volume');

  /// Pass any AudioManager Stream as a paremeter to this fucntion and the
  /// volume buttons and setVol ( int ) function will control that particular volume.
  static Future<Null> controlVolume(AudioManager audioManager) async {
    Map<String, int> map = <String, int>{};
    map.putIfAbsent("streamType", () {
      return _getInt(audioManager);
    });
    await _channel.invokeMethod('controlVolume', map);
    return null;
  }

  /// Returns an int which is the Max Possible volume for the selected
  /// AudioManager Stream same as that passed in the
  /// controlVolume ( AudioManager )  function.
  ///
  /// Can be implemented like this :-
  ///
  /// int maxVol = await Volume.getMaxVol;
  static Future<int> get getMaxVol async {
    int maxVol = await _channel.invokeMethod('getMaxVol');
    return maxVol;
  }

  /// Returns an int which is the current volume for the selected
  /// AudioManager Stream same as that passed in the
  /// controlVolume ( AudioManager )  function.
  ///
  /// Can be implemented like this :-
  ///
  /// int currentVol = await Volume.getVol;
  static Future<int> get getVol async {
    int vol = await _channel.invokeMethod('getVol');
    return vol;
  }

  /// Call this funtion with an integer value to set the volume of the selected
  /// AudioManager stream but value should be less then value returned by getMaxVol getter
  ///
  /// Can be implemented as :-
  ///
  /// await Volume.setVol ( int i );
  ///
  /// where value of 'i' is less then Volume.getMaxVol
  static Future<int> setVol(int i) async {
    Map<String, int> map = <String, int>{};
    map.putIfAbsent("newVol", () {
      return i;
    });
    int vol = await _channel.invokeMethod('setVol', map);
    return vol;
  }

  /// Press VolumeUp button programatically.
  /// It returns a null.
  /// 
  /// Implementaion :- 
  /// 
  /// Volume.volUp()
  static Future<Null> volUp() async{
    await SystemShortcuts.volUp();
  }

  /// Press VolumeDown button programatically.
  /// It returns a null.
  /// 
  /// Implementaion :- 
  /// 
  /// Volume.volDown()
  static Future<Null> volDown() async{
    await SystemShortcuts.volDown();
  }
}

int _getInt(AudioManager audioManager) {
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
