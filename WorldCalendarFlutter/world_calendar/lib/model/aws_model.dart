import 'dart:io';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:world_calendar/amplifyconfiguration.dart';
import 'package:world_calendar/model/log_model.dart';

class AWSModel {
  static final AWSModel _model = AWSModel();
  static AWSModel get instance => _model;

  AWSModel();

  Future<void> initialize() async {
    try {
      await Amplify.addPlugins([
        AmplifyAuthCognito(),
        AmplifyStorageS3(),
      ]);
      await Amplify.configure(amplifyconfig);
    } on Exception catch (e, stackTrace) {
      LogModel.instance.print('Error configuring Amplify: $e', stackTrace: stackTrace);
    }
  }

  Future<Map<String, String?>> getCredentialMap() async {
    final CognitoAuthSession session = await Amplify.Auth.fetchAuthSession() as CognitoAuthSession;
    final AWSCredentials credentials = session.credentialsResult.value;
    return {
      'accessKeyId': credentials.accessKeyId,
      'secretAccessKey': credentials.secretAccessKey,
      'sessionToken': credentials.sessionToken,
    };
  }

  Future<bool?> getIsFileExists(String key) async {
    try {
      final result = await Amplify.Storage.list(
        path: StoragePath.fromString(key),
      ).result;
      return result.items.any((item) {
        return item.path == key;
      });
    } on StorageException catch (e, stackTrace) {
      LogModel.instance.print('getIsFileExists key: $key Error: $e', stackTrace: stackTrace);
      return null;
    }
  }

  Future<bool> downloadFile(String key, String filePath) async {
    try {
      await Amplify.Storage.downloadFile(
        path: StoragePath.fromString(key),
        localFile: AWSFile.fromPath(filePath),
      ).result;
      return File(filePath).existsSync();
    } catch (e, stackTrace) {
      LogModel.instance.print('downloadFile key: $key Error: $e', stackTrace: stackTrace);
    }
    return false;
  }
}