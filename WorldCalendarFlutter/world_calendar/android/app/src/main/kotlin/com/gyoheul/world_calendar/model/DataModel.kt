package com.gyoheul.world_calendar.model

import android.content.Context
import com.gyoheul.world_calendar.data.RelatedAppData
import kotlinx.serialization.json.Json
import java.io.File
import java.text.SimpleDateFormat
import java.util.Date

object DataModel {
    private const val KEY_RELATED_APP_JSON: String = "data/related_app.json"
    private const val KEY_RELATED_APP_DATE: String = "data/related_app_date.txt"
    private const val KEY_ICON: String = "data/icon"

    suspend fun getRelatedAppDataList(context: Context): List<RelatedAppData> {
        val relatedAppDataList: MutableList<RelatedAppData> = mutableListOf()

        val dateFile: File = FileModel.getCacheFile(context, KEY_RELATED_APP_DATE)
        val dateSuccess = AWSModel.downloadFile(KEY_RELATED_APP_DATE, dateFile)
        if (dateSuccess) {
            val modifyDateString: String = dateFile.readText().trim()
            val modifyDate: Date = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(modifyDateString)

            val relatedAppJsonFile: File = FileModel.getCacheFile(context, KEY_RELATED_APP_JSON)
            val needDownload: Boolean =
                if (relatedAppJsonFile.exists()) {
                    if (modifyDate.before(Date(relatedAppJsonFile.lastModified()))) {
                        false
                    } else {
                        relatedAppJsonFile.delete()
                        true
                    }
                } else {
                    true
                }

            if (needDownload) {
                val appSuccess = AWSModel.downloadFile(KEY_RELATED_APP_JSON, relatedAppJsonFile)
                if (appSuccess) {
                    val relatedAppJsonString: String = relatedAppJsonFile.readText()
                    val relatedAppJsonList: List<RelatedAppData> = Json.decodeFromString(relatedAppJsonString)
                    relatedAppDataList.run {
                        clear()
                        addAll(relatedAppJsonList)
                    }

                    downloadIconFile(context, relatedAppDataList, true)
                }
            }

            if (relatedAppJsonFile.exists() && relatedAppDataList.isEmpty()) {
                val relatedAppJsonString: String = relatedAppJsonFile.readText()
                val relatedAppJsonList: List<RelatedAppData> = Json.decodeFromString(relatedAppJsonString)
                relatedAppDataList.run {
                    clear()
                    addAll(relatedAppJsonList)
                }
            }

            downloadIconFile(context, relatedAppDataList, false)
        }

        return relatedAppDataList
    }

    private suspend fun downloadIconFile(context: Context, relatedAppDataList: List<RelatedAppData>, isForce: Boolean) {
        for (relatedAppData: RelatedAppData in relatedAppDataList) {
            val iconKey = "$KEY_ICON/${relatedAppData.icon}"
            val iconFile = FileModel.getCacheFile(context, iconKey)
            if (!iconFile.exists() || isForce) {
                AWSModel.downloadFile(iconKey, iconFile)
            }
        }
    }
}