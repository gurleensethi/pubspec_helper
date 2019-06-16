import 'package:pubspec_helper/helpers/file_helper.dart';
import 'package:pubspec_helper/models/dependency.dart';
import 'package:yaml/yaml.dart' as yaml;

class PubspecEditor {
  final List<Dependency> _dependencies = [];
  final FileHelper fileHelper;
  final Map<String, dynamic> _pubspecContent = {};

  List<Dependency> get dependencies => _dependencies;

  PubspecEditor({
    this.fileHelper,
  }) {
    _parseContent();
  }

  void _parseContent() {
    yaml.YamlMap yamlMap = yaml.loadYaml(fileHelper.content);

    _pubspecContent.addAll(_convertYamlMapToMap(yamlMap));

    // Read all the dependencies
    _pubspecContent['dependencies'].keys.forEach((key) {
      _dependencies.add(Dependency(
        name: key,
        version:
            _normaliseDependencyVersion(_pubspecContent['dependencies'][key]),
      ));
    });
  }

  /// Convert [yaml.YamlMap] to [Map<String, dynamic>]
  Map<String, dynamic> _convertYamlMapToMap(yaml.YamlMap yamlMap) {
    final map = <String, dynamic>{};

    for (final entry in yamlMap.entries) {
      if (entry.value is yaml.YamlMap || entry.value is Map) {
        map[entry.key.toString()] = _convertYamlMapToMap(entry.value);
      } else {
        map[entry.key.toString()] = entry.value.toString();
      }
    }

    return map;
  }

  String _normaliseDependencyVersion(String version) {
    if (version.contains("^")) {
      return version.split("^")[1];
    }
    return version;
  }

  /// Replace the current dependencies with the new ones.
  /// [dependencies] are new dependencies.
  void updateDependencies(List<Dependency> dependencies) {
    _dependencies.clear();
    _dependencies.addAll(dependencies);
  }

  /// Write the contents of updated pubspec to file.
  /// Update the parsed [yaml.YamlMap] with newly provided data.
  void write() {
    // Map dependency [List] to [Map].
    final dependenciesAsMap = _dependencies
        .fold<Map<String, String>>(<String, String>{}, (map, dependency) {
      return map..[dependency.name] = "^${dependency.version}";
    });

    _pubspecContent['dependencies']..clear()..addAll(dependenciesAsMap);

    print(_pubspecContent);
    print(_convertMapToPubspecString(_pubspecContent, 0));
  }

  String _convertMapToPubspecString(Map<String, dynamic> map, int level) {
    String content = "";

    String spaces = "";
    for (int i = 0; i < level * 2; i++) {
      spaces += " ";
    }

    for (final entry in map.entries) {
      if (entry.value is Map) {
        content += "\n${spaces}${entry.key}:\n  ${_convertMapToPubspecString(entry.value, 1 + level)}";
      } else {
        content += "${spaces}${entry.key}:  ${entry.value}\n";
      }
    }

    return content;
  }
}
