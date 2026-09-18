package com.gyoheul.world_calendar

import android.content.Context
import android.view.LayoutInflater
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import com.gyoheul.world_calendar.NativeAdUtil.setViewNativeAd
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class TopNativeAdFactory(private val context: Context) : GoogleMobileAdsPlugin.NativeAdFactory {
    override fun createNativeAd(
        nativeAd: NativeAd,
        customOptions: MutableMap<String, Any>?
    ): NativeAdView {
        val nativeAdView = LayoutInflater.from(context).inflate(R.layout.small_native_ad, null) as NativeAdView
        return nativeAdView.setViewNativeAd(nativeAd)
    }
}