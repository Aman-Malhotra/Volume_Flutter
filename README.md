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

### Volume Buttons will affect this volume when in app

> await Volume.controlVolume(AudioManager audioManager); // pass any stream as parameter

### Returns maximum possible volume in integers

> await Volume.getMaxVol; // returns an integer

### Returns current volume level in integers

> await Volume.getVol;// returns an integer

### Set volume for the stream passed to controlVolume() function

> await Volume.setVol(int i); // Max value of i is less than Volume.getMaxVol

### Press Volume Up button programatically 

> Volume.volUp(); // press volUp key.

### Press Volume Down button programatically 

> Volume.volDown(); // press volDown key.

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
  // To implement the volume Up and volume Down button press programatically.
  
  FlatButton(
    child: Text("Vol Up"),
    onPressed: (){
      Volume.volUp();// Consecutively increasing the volume by 1 unit.
      updateVolumes();
    },
  ),
  FlatButton(
    child: Text("Vol Down"),
    onPressed: (){
      Volume.volDown();// Consecutively decrease the volume by 1 unit.
      updateVolumes();
    },
  )
```

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.io/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
