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

# Show and Hide System UI
```
ShowVolumeUI.SHOW (DEFAULT)          -> Show system volume UI while changing volume 
ShowVolumeUI.HIDE                    -> Do not show system volume UI while changing volume 
```
# Functions and getters

### Volume Buttons will affect this volume when in app

> await Volume.controlVolume(AudioManager audioManager); // pass any stream as parameter

### Returns maximum possible volume in integers

> await Volume.getMaxVol; // returns an integer

### Returns current volume level in integers

> await Volume.getVol;// returns an integer

### Set volume for the stream passed to controlVolume() function

> await Volume.setVol(int i, {ShowVolumeUI showVolumeUI});  

> Max value of i is less than or equal to Volume.getMaxVol. 

> Parameter showVolumeUI is optional parameter which defaults to ShowVolumeUI.SHOW.

<!-- ### Press Volume Up button programatically 

> Volume.volUp(); // press volUp key.

### Press Volume Down button programatically 

> Volume.volDown(); // press volDown key. -->

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
    await Volume.setVol(i, showVolumeUI: ShowVolumeUI.SHOW);
    // or 
    // await Volume.setVol(i, showVolumeUI: ShowVolumeUI.HIDE);
  }
  // To implement the volume Up and volume Down button press programatically.
  
```
