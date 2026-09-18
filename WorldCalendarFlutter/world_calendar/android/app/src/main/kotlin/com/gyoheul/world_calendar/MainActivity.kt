package com.gyoheul.world_calendar

import android.content.Context
import com.gyoheul.world_calendar.data.RelatedAppData
import com.gyoheul.world_calendar.model.AWSModel
import com.gyoheul.world_calendar.model.DataModel
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.serialization.builtins.ListSerializer
import kotlinx.serialization.json.Json

class MainActivity: FlutterActivity() {
    private val CHANNEL = "data_model_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "TopNativeAdFactoryId", TopNativeAdFactory(context))
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "DialogNativeAdFactoryId", DialogNativeAdFactory(context))
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "DrawerNativeAdFactoryId", DrawerNativeAdFactory(context))

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getRelatedAppJsonString") {
                val arguments = call.arguments as? Map<*, *> ?: emptyMap<Any, Any?>()
                val credentialMap = arguments.mapNotNull { entry ->
                    val key = entry.key as? String ?: return@mapNotNull null
                    val value = entry.value as? String
                    key to value
                }.toMap()
                CoroutineScope(Dispatchers.IO).launch {
                    val relatedAppJsonString = getRelatedAppJsonString(applicationContext, credentialMap)
                    result.success(relatedAppJsonString)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine)
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "TopNativeAdFactoryId")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "DialogNativeAdFactoryId")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "DrawerNativeAdFactoryId")
    }

    private suspend fun getRelatedAppJsonString(context: Context, credentialMap: Map<String, String?>): String {
        AWSModel.initialize(credentialMap)
        return Json.encodeToString(
            ListSerializer(RelatedAppData.serializer()),
            DataModel.getRelatedAppDataList(context)
        )
    }
}
