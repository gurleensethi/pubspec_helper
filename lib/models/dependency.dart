class Dependency {
  final String name;
  final String version;

  Dependency({
    this.name,
    this.version,
  });

  @override
  String toString() {
    return 'Dependency{name: $name, version: $version}';
  }
}
