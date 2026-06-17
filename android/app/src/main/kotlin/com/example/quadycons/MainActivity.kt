package com.example.quadycons

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "native_location"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val provider = NativeLocationProvider(this)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "getCurrentLocation") {
                provider.getCurrentLocation(
                    onSuccess = { lat, lon ->
                        result.success(
                            mapOf(
                                "lat" to lat,
                                "lon" to lon
                            )
                        )
                    },
                    onError = {
                        result.error(
                            "LOCATION_ERROR",
                            "No location available",
                            null
                        )
                    }
                )
            } else {
                result.notImplemented()
            }
        }
    }
}
