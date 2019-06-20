class PacakgeModel {
  final String name;
  final String version;
  final int score;
  final String description;
  final List<String> supportedPlatforms;
  final String lastUpdated;

  PacakgeModel({
    this.name,
    this.version,
    this.score,
    this.description,
    this.supportedPlatforms,
    this.lastUpdated,
  });

  @override
  String toString() {
    return "PackageModel("
        "name: $name, "
        "version: $version, "
        "score: $score, "
        "description: $description, "
        "supportedPlatforms: $supportedPlatforms, "
        "lastUpdated: $lastUpdated"
        ")";
  }
}
