package com.example.volume;

import android.annotation.TargetApi;
import android.app.Activity;
import android.content.Context;
import android.media.AudioManager;

import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * VolumePlugin
 */
public class VolumePlugin implements MethodCallHandler {

    private final MethodChannel channel;
    private Activity activity;
    AudioManager audioManager;
    private int streamType;

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "volume");
        channel.setMethodCallHandler(new VolumePlugin(registrar.activity(), channel));
    }

    private VolumePlugin(Activity activity, MethodChannel channel) {
        this.activity = activity;
        this.channel = channel;
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals("controlVolume")) {
            int i = call.argument("streamType");
            streamType = i;
            controlVolume(i);
        } else if (call.method.equals("getMaxVol")) {
            result.success(getMaxVol());
//            getMaxVol();
        } else if (call.method.equals("getVol")) {
            result.success(getVol());
//            getVol();
        } else if (call.method.equals("setVol")) {
            int i = call.argument("newVol");
            setVol(i);
        } else {
            result.notImplemented();
        }
    }

    void controlVolume(int i) {
        this.activity.setVolumeControlStream(i);
    }

    void initAudioManager() {
        audioManager = (AudioManager) this.activity.getApplicationContext().getSystemService(Context.AUDIO_SERVICE);
    }

    int getMaxVol() {
        initAudioManager();
        return audioManager.getStreamMaxVolume(streamType);
    }

    int getVol() {
        initAudioManager();
        return audioManager.getStreamVolume(streamType);
    }

    int setVol(int i) {
        initAudioManager();
        audioManager.setStreamVolume(streamType, i, AudioManager.FLAG_SHOW_UI);
        return audioManager.getStreamVolume(streamType);
    }
}
