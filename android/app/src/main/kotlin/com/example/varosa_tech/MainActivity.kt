package com.example.varosa_tech

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject
import java.time.ZonedDateTime
import java.time.format.DateTimeFormatter

class MainActivity : FlutterActivity() {
    private val CHANNEL = "varosa_tech/device_info"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getDeviceInfo" -> {
                    val deviceInfo = getDeviceInfo()
                    result.success(deviceInfo)
                }
                "getBatteryLevel" -> {
                    val batteryLevel = getBatteryLevel()
                    if (batteryLevel != -1) {
                        result.success(batteryLevel)
                    } else {
                        result.error("UNAVAILABLE", "Battery level not available.", null)
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }

        // Register the native button view factory
        flutterEngine.platformViewsController.registry.registerViewFactory(
            "varosa_tech/native_button", 
            NativeButtonViewFactory(flutterEngine.dartExecutor.binaryMessenger)
        )
    }

    private fun getDeviceInfo(): String {
        val batteryLevel = getBatteryLevel()
        val deviceModel = "${Build.MANUFACTURER} ${Build.MODEL}"
        val isCharging = isCharging()
        val systemTime = getCurrentTime()

        val jsonObject = JSONObject().apply {
            put("batteryLevel", batteryLevel)
            put("deviceModel", deviceModel)
            put("isCharging", isCharging)
            put("systemTime", systemTime)
        }

        return jsonObject.toString()
    }

    private fun getBatteryLevel(): Int {
        val batteryLevel = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            intent?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) ?: -1
        }
        return batteryLevel
    }

    private fun isCharging(): Boolean {
        val intentFilter = IntentFilter(Intent.ACTION_BATTERY_CHANGED)
        val batteryStatus = registerReceiver(null, intentFilter)
        val status = batteryStatus?.getIntExtra(BatteryManager.EXTRA_STATUS, -1) ?: -1
        return status == BatteryManager.BATTERY_STATUS_CHARGING || status == BatteryManager.BATTERY_STATUS_FULL
    }

    private fun getCurrentTime(): String {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            ZonedDateTime.now().format(DateTimeFormatter.ISO_INSTANT)
        } else {
            java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", java.util.Locale.getDefault()).format(java.util.Date())
        }
    }
}
