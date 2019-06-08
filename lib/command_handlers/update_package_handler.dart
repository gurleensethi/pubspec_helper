import 'package:path/path.dart';
import 'package:pubspec_helper/command_handlers/command_handler.dart';
import 'package:pubspec_helper/helpers/network_helper.dart';
import 'package:pubspec_helper/helpers/pubspec_editor.dart';
import 'package:pubspec_helper/models/dependency.dart';
import 'package:html/parser.dart' show parse;

class UpdatePackageHandler implements CommandHandler {
  @override
  void handleCommand(PubspecEditor editor) {
    _validateDependencies(editor.dependencies);
    _printNumOfDependencies(editor.dependencies);

    editor.dependencies.forEach((dep) {
      _comparePackageVersionFromPub(dep);
    });
  }

  void _validateDependencies(List<Dependency> dependencies) {
    if (dependencies == null || dependencies.isEmpty) {
      throw Exception("No dependencies found in file!}!");
    }
  }

  void _printNumOfDependencies(List<Dependency> dependencies) {
    print("${dependencies.length} dependencies found!");
  }

  /// Returns a String message is update is required by comparing with pub.
  Future<String> _comparePackageVersionFromPub(Dependency dependency) async {
    try {
      final pubHtml =
          await NetworkHelper.fetchPackagePubWebsite(dependency.name);
      final parsedHtmlDoc = parse(pubHtml);

      final oldPackage = "${dependency.name} ${dependency.version}";

      final newPackage = parsedHtmlDoc
          .getElementsByClassName("package-header")[0]
          .getElementsByClassName('title')[0]
          .text
          .trim();

      print(dependency.name);
      print("  Current: [$oldPackage]\n  From Pub: [$newPackage]");

      if (oldPackage != newPackage) {
        return "Update Required:\n  $oldPackage --> $newPackage";
      }
    } catch (error) {
      print('Unable to fetch details for ${dependency.name}');
      return null;
    }

    return null;
  }
}
