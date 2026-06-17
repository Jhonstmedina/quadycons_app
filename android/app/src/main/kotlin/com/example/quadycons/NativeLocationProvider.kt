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
        val request = LocationRequest.create().apply {
            priority = LocationRequest.PRIORITY_BALANCED_POWER_ACCURACY
            numUpdates = 1
            interval = 0
            fastestInterval = 0
        }

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
            callback!!,
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
