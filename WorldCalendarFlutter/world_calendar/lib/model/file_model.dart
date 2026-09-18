import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileModel {
  static final FileModel _model = FileModel();
  static FileModel get instance => _model;

  final String _relatedAppIconDirPath = 'data/icon';

  FileModel();

  Future<File> getCacheFile(String fileName) async {
    final Directory cacheDir = await getTemporaryDirectory();
    final String filePath = '${cacheDir.path}/$fileName';

    // 中間ディレクトリパスの生成
    final File targetFile = File(filePath);
    await targetFile.parent.create(recursive: true);

    return targetFile;
  }

  Future<File> getIconFile(String iconName) async {
    final Directory cacheDir = await getTemporaryDirectory();
    final String filePath = '${cacheDir.path}/$_relatedAppIconDirPath/$iconName';

    // 中間ディレクトリパスの生成
    final File targetFile = File(filePath);
    await targetFile.parent.create(recursive: true);

    return targetFile;
  }
}