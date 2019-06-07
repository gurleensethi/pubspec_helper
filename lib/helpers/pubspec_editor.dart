import 'package:pubspec_helper/helpers/file_helper.dart';
import 'package:pubspec_helper/models/dependency.dart';
import 'package:yaml/yaml.dart' as yaml;

class PubspecEditor {
  final List<Dependency> _dependencies = [];
  final FileHelper fileHelper;

  List<Dependency> get dependencies => _dependencies;

  PubspecEditor({
    this.fileHelper,
  }) {
    _parseContent();
  }

  void _parseContent() {
    yaml.YamlMap content = yaml.loadYaml(fileHelper.content);

    // Read all the dependencies
    content['dependencies'].keys.forEach((key) {
      _dependencies.add(Dependency(
        name: key,
        version: _normaliseDependencyVersion(content['dependencies'][key]),
      ));
    });
  }

  String _normaliseDependencyVersion(String version) {
    if (version.contains("^")) {
      return version.split("^")[1];
    }
    return version;
  }
}
