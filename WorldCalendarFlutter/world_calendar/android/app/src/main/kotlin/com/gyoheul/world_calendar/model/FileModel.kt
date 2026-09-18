package com.gyoheul.world_calendar.model

import android.content.Context
import java.io.File

object FileModel {
    fun getCacheFile(context: Context, fileName: String): File {
        val cacheDir: File = context.cacheDir
        val targetFile = File(cacheDir, fileName)
        val parentDir = targetFile.parentFile

        if (parentDir != null && !parentDir.exists()) {
            parentDir.mkdirs()
        }
        return targetFile
    }
}