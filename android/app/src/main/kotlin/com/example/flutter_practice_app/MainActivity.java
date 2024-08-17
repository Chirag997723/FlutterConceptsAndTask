// MainActivity.java
package com.example.flutter_practice_app;

import android.content.Intent;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.example.flutter_practice_app/video";

    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("startVideoService")) {
                                startService(new Intent(this, VideoService.class));
                                result.success(null);
                            } else if (call.method.equals("stopVideoService")) {
                                stopService(new Intent(this, VideoService.class));
                                result.success(null);
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }
}
