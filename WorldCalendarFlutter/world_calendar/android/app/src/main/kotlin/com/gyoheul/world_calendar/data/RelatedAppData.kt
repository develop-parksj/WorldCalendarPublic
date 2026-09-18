package com.gyoheul.world_calendar.data

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class RelatedAppData(
    val title: String,
    @SerialName("title_ja")
    val titleJa: String,
    @SerialName("title_ko")
    val titleKo: String,
    val detail: String,
    @SerialName("detail_ja")
    val detailJa: String,
    @SerialName("detail_ko")
    val detailKo: String,
    val icon: String,
    @SerialName("package")
    val packageName: String,
)