import 'package:pubpsec_updater/argument_validator.dart' show validateArgs;

import 'dart:io';
import 'package:yaml/yaml.dart';

void updatePackages(List<String> args) async {
  try {
    final pubspecFile = await validateArgs(args);
    final map = readYamlFile(pubspecFile);
    final dependencies = _extractDependencies(map);
  } on Exception catch (error) {
    print(error);
  }
}

 YamlMap readYamlFile(File yamlFile) {
  final String fileContents = yamlFile.readAsStringSync();
  final doc = loadYaml(fileContents);
  return doc;
}

Map<String, String> _extractDependencies(YamlMap map) {
  // Check if there are no dependencies in the pubspec file.
  if (map['dependencies'] == null || map['dependencies'].length == 0) {
    throw Exception("\nNo dependencies found!");
  }

  // Iterate and convert all the dependences to a <String, String> map.
  return map['dependencies'].keys.fold(<String, String>{}, (deps, key) {
    deps[key] = map['dependencies'][key];
    return deps;
  });
}