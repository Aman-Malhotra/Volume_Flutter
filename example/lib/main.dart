import 'package:flutter/material.dart';
import 'dart:async';
import 'package:volume/volume.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AudioManager audioManager;
  int maxVol, currentVol;

  
  @override
  void initState() {
    super.initState();
    audioManager = AudioManager.STREAM_SYSTEM;
    initPlatformState();
    updateVolumes();
  }

  Future<void> initPlatformState() async {
    await Volume.controlVolume(AudioManager.STREAM_SYSTEM);
  }

  updateVolumes() async {
    // get Max Volume
    maxVol = await Volume.getMaxVol;
    // get Current Volume
    currentVol = await Volume.getVol;
    setState(() {});
  }

  setVol(int i) async {
    await Volume.setVol(i);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButton(
                value: audioManager,
                items: [
                  DropdownMenuItem(
                    child: Text("In Call Volume"),
                    value: AudioManager.STREAM_VOICE_CALL,
                  ),
                  DropdownMenuItem(
                    child: Text("System Volume"),
                    value: AudioManager.STREAM_SYSTEM,
                  ),
                  DropdownMenuItem(
                    child: Text("Ring Volume"),
                    value: AudioManager.STREAM_RING,
                  ),
                  DropdownMenuItem(
                    child: Text("Media Volume"),
                    value: AudioManager.STREAM_MUSIC,
                  ),
                  DropdownMenuItem(
                    child: Text("Alarm volume"),
                    value: AudioManager.STREAM_ALARM,
                  ),
                  DropdownMenuItem(
                    child: Text("Notifications Volume"),
                    value: AudioManager.STREAM_NOTIFICATION,
                  ),
                ],
                isDense: true,
                onChanged: (AudioManager aM) async {
                  print(aM.toString());
                  setState(() {
                    audioManager = aM;
                  });
                  await Volume.controlVolume(aM);
                },
              ),
              (currentVol != null || maxVol != null)
                  ? Slider(
                      value: currentVol / 1.0,
                      divisions: maxVol,
                      max: maxVol / 1.0,
                      min: 0,
                      onChanged: (double d) {
                        setVol(d.toInt());
                        updateVolumes();
                      },
                    )
                  : Container(),

              FlatButton(
                child: Text("Vol Up"),
                onPressed: (){
                  Volume.volUp();
                  updateVolumes();
                },
              ),
              FlatButton(
                child: Text("Vol Down"),
                onPressed: (){
                  Volume.volDown();
                  updateVolumes();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
