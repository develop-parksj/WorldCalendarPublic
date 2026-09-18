package com.gyoheul.world_calendar.model

import aws.sdk.kotlin.runtime.auth.credentials.StaticCredentialsProvider
import aws.sdk.kotlin.services.s3.S3Client
import aws.sdk.kotlin.services.s3.model.GetObjectRequest
import aws.sdk.kotlin.services.s3.model.GetObjectResponse
import aws.smithy.kotlin.runtime.auth.awscredentials.Credentials
import aws.smithy.kotlin.runtime.content.writeToFile
import java.io.File

object AWSModel {
    private val logTag: String = javaClass.name

    private lateinit var s3Client: S3Client

    fun initialize(credentialMap: Map<String, String?>) {
        s3Client = S3Client {
            region = "ap-northeast-1"
            credentialsProvider = StaticCredentialsProvider(
                Credentials(
                    accessKeyId = credentialMap["accessKeyId"] ?: "",
                    secretAccessKey = credentialMap["secretAccessKey"] ?: "",
                    sessionToken = credentialMap["sessionToken"],
                )
            )
        }
    }

    suspend fun downloadFile(key: String, file: File): Boolean {
        return try {
            s3Client.getObject(
                GetObjectRequest.invoke {
                    bucket = "YOUR_BUCKET_NAME"
                    this.key = key
                }
            ) { response: GetObjectResponse ->
                if (file.exists()) {
                    file.delete()
                }
                response.body?.writeToFile(file)

                file.exists()
            }
        } catch (e: Exception) {
            false
        }
    }
}