# volume

Controll Volume in Android programatically.
No IOS Implementation yet . Pull Request for ios implementation are welcome.

# Streams
```
AudioManager.STREAM_VOICE_CALL       -> Controll IN CALL Volume
AudioManager.STREAM_SYSTEM           -> Controll SYSTEM Volume
AudioManager.STREAM_RING             -> Controll RINGER Volume
AudioManager.STREAM_MUSIC            -> Controll MEDIA Volume
AudioManager.STREAM_ALARM            -> Controll ALARM Volume
AudioManager.STREAM_NOTIFICATION     -> Controll NOTIFICATION Volume
```
# Functions and getters

**your app will control this vol when in app**

```await Volume.controlVolume(AudioManager audioManager); // pass any stream as parameter```

**get maximum possible volume**

```await Volume.getMaxVol; // returns an integer```

**get current volume level**

```await Volume.getVol;// returns an integer```

**set volume for the selected stream as a parameter to controlVolume**

// the vol will be set to the integer value sent as parameter. Max value of `i` is less than Volume.getMaxVol

```await Volume.setVol(int i); ```

# Usage
```
class _MyAppState extends State<MyApp> {
  int maxVol, currentVol;

  @override
  void initState() {
    super.initState();
    // Make this call in initState() function in the root widgte of your app
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    // pass any stream as parameter as per requirement
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
```

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.io/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
