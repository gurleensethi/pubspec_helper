import 'package:args/args.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

Future<File> validateArgs(List<String> args) async {
  // Make sure a file is provided in args.
  var parser = ArgParser()..addOption("file", abbr: "f");
  final results = parser.parse(args);

  if (results['file'] == null) {
    throw Exception("\nPlease specify a .yaml file to be used!"
        "\nFor example:"
        "\n\tdartaotrumtime pubpsec_updater.yaml -f pubspec.yaml");
  }

  // Make sure the provided file exists
  final file = File(results['file']);

  if (!(await file.exists())) {
    throw Exception("\nFile \"${file.path}\" doesn't exists!"
        "\nMake sure to provide a correct file path.");
  }

  // Make sure a .yaml file is provided
  final fileExtension = path.extension(file.path);

  if (fileExtension != ".yaml") {
    throw Exception("\n\"${file.path}\" is not a valid file!"
        "\nPlease provide a \".yaml\" file.");
  }

  return file;
}
