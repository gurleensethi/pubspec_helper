import 'dart:io';
import 'package:path/path.dart';

class FileHelper {
  final String filePath;
  final File _targetFile;

  FileHelper({
    this.filePath,
  }) : _targetFile = File(filePath);

  String get content => _targetFile.readAsStringSync();

  /// File must be of [fileExtension] type.
  Future<void> validateFile(String fileExtension) async {
    // Check if file exists
    final fileExists = await _targetFile.exists();

    if (!fileExists) {
      throw Exception("File $filePath doesn't exist!");
    }

    // Check that file matches the extension
    if (extension(_targetFile.path) != fileExtension) {
      throw Exception("$filePath is not supported! "
          "Please provide a '$fileExtension' file");
    }
  }
}
