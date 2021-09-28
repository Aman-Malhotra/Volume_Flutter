import 'dart:async';
import 'package:flutter/services.dart';

/// AudioManager Streams control the type of volume the getVol and setVol function will control.
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
  STREAM_NOTIFICATION
}

enum ShowVolumeUI {
  /// HIDE System UI while changing volume,
  SHOW,

  /// HIDE System UI while changing volume,
  HIDE
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

  /// Pass any AudioManager Stream as a parameter to this function and the
  /// volume buttons and setVol (...) function will control that particular volume.
  static Future<Null> controlVolume(AudioManager audioManager) async {
    Map<String, int?> map = <String, int?>{};
    map.putIfAbsent("streamType", () {
      return _getStreamInt(audioManager);
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
  static Future<int?> get getMaxVol async {
    int? maxVol = await _channel.invokeMethod('getMaxVol');
    return maxVol;
  }

  /// Returns an int which is the current volume for the selected
  /// AudioManager Stream same as that passed in the
  /// controlVolume ( AudioManager )  function.
  ///
  /// Can be implemented like this :-
  ///
  /// int currentVol = await Volume.getVol;
  static Future<int?> get getVol async {
    int? vol = await _channel.invokeMethod('getVol');
    return vol;
  }

  /// Call this function with an integer value to set the volume of the selected.
  /// OPTIONAL PARAMETER [ShowVolumeUI showVolumeUI]
  /// to show or hide system Volume UI while changing the volume.
  /// AudioManager stream but value should be less then value returned by getMaxVol getter
  ///
  /// Can be implemented as :-
  ///
  /// await Volume.setVol ( int i, ShowVolumeUI showVolumeUI );
  ///
  /// where value of 'i' is less then Volume.getMaxVol
  ///
  /// value of showVolumeUI can have two values [ShowVolumeUI.SHOW] and [ShowVolumeUI.HIDE]
  static Future<int?> setVol(int i,
      {ShowVolumeUI showVolumeUI = ShowVolumeUI.SHOW}) async {
    Map<String, int> map = <String, int>{};
    map.putIfAbsent("newVol", () {
      return i;
    });
    map.putIfAbsent("showVolumeUiFlag", () {
      return _getShowVolumeUiInt(showVolumeUI);
    });
    int? vol = await _channel.invokeMethod('setVol', map);
    return vol;
  }

  /// Press VolumeUp button programmatically.
  /// It returns a null.
  ///
  /// Implementation :-
  ///
  /// Volume.volUp()
  // static Future<Null> volUp() async{
  //   await SystemShortcuts.volUp();
  // }

  /// Press VolumeDown button programmatically.
  /// It returns a null.
  ///
  /// Implementation :-
  ///
  /// Volume.volDown()
  // static Future<Null> volDown() async{
  //   await SystemShortcuts.volDown();
  // }
}

int _getShowVolumeUiInt(ShowVolumeUI showVolumeUI) {
  switch (showVolumeUI) {
    case ShowVolumeUI.SHOW:
      return 1;
    case ShowVolumeUI.HIDE:
      return 0;
    default:
      return 1;
  }
}

int? _getStreamInt(AudioManager audioManager) {
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
