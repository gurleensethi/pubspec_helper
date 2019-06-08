class Dependency {
  final String name;
  final String version;

  Dependency({
    this.name,
    this.version,
  });

  Dependency copyWith({
    String name,
    String version,
  }) {
    return Dependency(
      name: name ?? this.name,
      version: version ?? this.version,
    );
  }

  @override
  String toString() {
    return 'Dependency{name: $name, version: $version}';
  }
}
