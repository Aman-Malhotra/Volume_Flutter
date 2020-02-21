package com.example.volumeexample;

import android.os.Bundle;

import com.example.volume.VolumePlugin;

import io.flutter.app.FlutterActivity;

public class EmbeddingV1Activity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        VolumePlugin.registerWith(registrarFor("com.example.volume.VolumePlugin"));
    }
}