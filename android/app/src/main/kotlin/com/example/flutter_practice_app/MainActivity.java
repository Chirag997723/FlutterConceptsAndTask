// MainActivity.java
package com.example.flutter_practice_app;

import android.content.Intent;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import android.util.Log;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "myFirstMethodChannel";

    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("sendString")) {
                                String receivedString = call.argument("sendSms");
                                Log.i("androidLog", receivedString);
                                result.success("success");
                            }else {
                                result.notImplemented();
                            }
                        }
                );
    }
}
