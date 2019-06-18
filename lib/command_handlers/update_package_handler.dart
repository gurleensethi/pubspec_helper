import 'package:path/path.dart';
import 'package:pubspec_helper/command_handlers/command_handler.dart';
import 'package:pubspec_helper/helpers/network_helper.dart';
import 'package:pubspec_helper/helpers/pubspec_editor.dart';
import 'package:pubspec_helper/models/dependency.dart';
import 'package:html/parser.dart' show parse;

class UpdatePackageHandler implements CommandHandler<PubspecEditor> {
  @override
  void handleCommand(PubspecEditor editor) async {
    _validateDependencies(editor.dependencies);
    _printNumOfDependencies(editor.dependencies);

    final updatedDependencies =
        await _updateDependenciesFromPub(editor.dependencies);

    final updateCount = _countDependenciesThatRequireUpdate(
        editor.dependencies, updatedDependencies);

    _printDependenciesThatRequireUpdate(updateCount);

    _prettyPrint(editor.dependencies, updatedDependencies);
  }

  void _validateDependencies(List<Dependency> dependencies) {
    if (dependencies == null || dependencies.isEmpty) {
      throw Exception("No dependencies found in file!}!");
    }
  }

  void _printNumOfDependencies(List<Dependency> dependencies) {
    print("${dependencies.length} dependencies found.");
  }

  void _printDependenciesThatRequireUpdate(int count) {
    if (count == 0) {
      print("All dependencies are up to date!");
    } else {
      print("$count ${count == 1 ? "dependency" : "dependencies"} "
          "require update!");
    }
  }

  void _prettyPrint(List<Dependency> oldDependencies, List<Dependency> updatedDependencies) {
    print("");

    for (int i = 0; i < oldDependencies.length; i++) {
      final oldDependency = oldDependencies[i];
      final updatedDependency = updatedDependencies[i];

      if (oldDependency.version != updatedDependency.version) {
        print("${oldDependency.name}:");
        print("  ${oldDependency.version} -> ${updatedDependency.version}\n");
      }
    }
  }

  int _countDependenciesThatRequireUpdate(
    List<Dependency> oldDependencies,
    List<Dependency> updatedDependencies,
  ) {
    int updateCount = 0;

    for (int i = 0; i < oldDependencies.length; i++) {
      if (oldDependencies[i].version != updatedDependencies[i].version) {
        updateCount++;
      }
    }

    return updateCount;
  }

  Future<List<Dependency>> _updateDependenciesFromPub(
      List<Dependency> dependencies) async {
    final futures = dependencies.map(_getDependencyFromPub);
    return Future.wait(futures);
  }

  /// Returns a String message is update is required by comparing with pub.
  Future<Dependency> _getDependencyFromPub(Dependency dependency) async {
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

      if (oldPackage != newPackage) {
        return dependency.copyWith(version: newPackage.split(" ")[1]);
      }
    } catch (error) {
      return dependency;
    }

    return dependency;
  }
}
