package com.follow.clashx

import android.os.Build
import android.os.Bundle
import com.follow.clashx.plugins.AppPlugin
import com.follow.clashx.plugins.ServicePlugin
import com.follow.clashx.plugins.TilePlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            window.attributes.preferredDisplayModeId = getHighestRefreshRateDisplayMode()
        }
    }

    private fun getHighestRefreshRateDisplayMode(): Int {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val modes = windowManager.defaultDisplay.supportedModes
            var maxRefreshRate = 60f
            var modeId = 0
            
            for (mode in modes) {
                if (mode.refreshRate > maxRefreshRate) {
                    maxRefreshRate = mode.refreshRate
                    modeId = mode.modeId
                }
            }
            return modeId
        }
        return 0
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine.plugins.add(AppPlugin())
        flutterEngine.plugins.add(ServicePlugin)
        flutterEngine.plugins.add(TilePlugin())
        GlobalState.flutterEngine = flutterEngine
    }

    override fun onDestroy() {
        GlobalState.flutterEngine = null
        GlobalState.runState.value = RunState.STOP
        super.onDestroy()
    }
}