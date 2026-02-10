package com.example.quadycons

import android.annotation.SuppressLint
import android.content.Context
import android.os.Looper
import com.google.android.gms.location.*

class NativeLocationProvider(context: Context) {

    private val fusedClient =
        LocationServices.getFusedLocationProviderClient(context)

    private var callback: LocationCallback? = null

    @SuppressLint("MissingPermission")
    fun getCurrentLocation(
        onSuccess: (Double, Double) -> Unit,
        onError: () -> Unit
    ) {
        val request = LocationRequest.Builder(
            Priority.PRIORITY_BALANCED_POWER_ACCURACY, // 🔥 rápido, no GPS puro
            0
        )
            .setMaxUpdates(1)
            .setWaitForAccurateLocation(false)
            .build()

        callback = object : LocationCallback() {
            override fun onLocationResult(result: LocationResult) {
                val location = result.lastLocation
                if (location != null) {
                    onSuccess(location.latitude, location.longitude)
                } else {
                    onError()
                }
                stop()
            }
        }

        fusedClient.requestLocationUpdates(
            request,
            callback as LocationCallback,
            Looper.getMainLooper()
        )
    }

    fun stop() {
        callback?.let {
            fusedClient.removeLocationUpdates(it)
        }
        callback = null
    }
}
