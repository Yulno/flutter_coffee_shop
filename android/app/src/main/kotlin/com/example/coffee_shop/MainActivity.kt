package com.example.flutter_coffee_shop

import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        var key = getString(R.string.api_key)
        MapKitFactory.setApiKey(key)
        super.configureFlutterEngine(flutterEngine)
    }
}
