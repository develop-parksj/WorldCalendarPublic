package com.gyoheul.world_calendar

import android.text.TextUtils
import android.widget.Button
import android.widget.ImageView
import android.widget.RatingBar
import android.widget.TextView
import androidx.constraintlayout.widget.ConstraintLayout
import com.google.android.gms.ads.nativead.MediaView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView

object NativeAdUtil {
    fun NativeAdView.setViewNativeAd(nativeAd: NativeAd): NativeAdView {
        with(this) {
            val primaryView: TextView? = findViewById(R.id.primary)
            val secondaryView: TextView? = findViewById(R.id.secondary)
            val tertiaryView: TextView? = findViewById(R.id.body)

            val ratingBar: RatingBar? = findViewById(R.id.rating_bar)
            ratingBar?.isEnabled = false

            val callToActionView: Button? = findViewById(R.id.cta)
            val iconView: ImageView? = findViewById(R.id.icon)
            val mediaView: MediaView? = findViewById(R.id.media_view)
            val background: ConstraintLayout? = findViewById(R.id.background)

            background?.setBackgroundColor(android.graphics.Color.WHITE)
            primaryView?.setBackgroundColor(android.graphics.Color.WHITE)
            secondaryView?.setBackgroundColor(android.graphics.Color.WHITE)
            tertiaryView?.setBackgroundColor(android.graphics.Color.WHITE)

            val store = nativeAd.store
            val advertiser = nativeAd.advertiser
            val headline = nativeAd.headline
            val body = nativeAd.body
            val cta = nativeAd.callToAction
            val starRating = nativeAd.starRating
            val icon = nativeAd.icon

            val secondaryText: String?

            this.callToActionView = callToActionView
            this.headlineView = primaryView
            this.mediaView = mediaView
            secondaryView?.visibility = android.view.View.VISIBLE
            if (adHasOnlyStore(nativeAd)) {
                this.storeView = secondaryView
                secondaryText = store
            } else if (!TextUtils.isEmpty(advertiser)) {
                this.advertiserView = secondaryView
                secondaryText = advertiser
            } else {
                secondaryText = ""
            }

            primaryView?.text = headline
            callToActionView?.text = cta

            if (starRating != null && starRating > 0) {
                secondaryView?.visibility = android.view.View.GONE
                ratingBar?.visibility = android.view.View.VISIBLE
                ratingBar?.rating = starRating.toFloat()
                this.starRatingView = ratingBar
            } else {
                secondaryView?.text = secondaryText
                secondaryView?.visibility = android.view.View.VISIBLE
                ratingBar?.visibility = android.view.View.GONE
            }

            iconView?.run {
                if (icon != null) {
                    visibility = android.view.View.VISIBLE
                    setImageDrawable(icon.drawable)
                } else {
                    visibility = android.view.View.GONE
                }
            }

            if (tertiaryView != null) {
                tertiaryView.text = body
                this.bodyView = tertiaryView
            }

            setNativeAd(nativeAd)
        }

        return this
    }

    private fun adHasOnlyStore(nativeAd: NativeAd): Boolean {
        val store = nativeAd.store
        val advertiser = nativeAd.advertiser
        return !TextUtils.isEmpty(store) && TextUtils.isEmpty(advertiser)
    }
}