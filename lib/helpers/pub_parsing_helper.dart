import 'package:pubspec_helper/models/package_model.dart';
import 'package:html/parser.dart';

/// Contains various functions to parse html from various pages from https://pub.dev
class PubParsingHelper {
  Future<List<PacakgeModel>> getPackagesListFromSearch(
      String searchPageHtml) async {
    final parsedHtmlDoc = parse(searchPageHtml);

    final packageListDoc = parsedHtmlDoc.getElementsByClassName("package-list");

    return packageListDoc[0].children.map((packageElement) {
      final packageName =
          packageElement.getElementsByClassName("title")[0].text?.trim();
      final packageDescription =
          packageElement.getElementsByClassName("description")[0].text?.trim();

      int packageScore;
      String packageVersion;
      String lastUpdated;
      final List<String> supportedPlatforms = [];

      // If is core dart package
      if (packageName.startsWith("dart:")) {
      } else {
        packageScore = int.parse(
            packageElement.getElementsByClassName("score-box")[0].text?.trim());

        final metaDataDoc =
            packageElement.getElementsByClassName("metadata")[0];
        final metaDataAnchorTags = metaDataDoc.getElementsByTagName("a");

        packageVersion = metaDataAnchorTags[0].text?.trim();

        supportedPlatforms.addAll(metaDataDoc
            .getElementsByClassName("package-tag")
            .map((element) => element.text?.trim())
            .toList());

        lastUpdated = metaDataDoc.getElementsByTagName("span")[0].text?.trim();
      }

      return PacakgeModel(
        name: packageName,
        description: packageDescription,
        version: packageVersion,
        score: packageScore,
        lastUpdated: lastUpdated,
        supportedPlatforms: supportedPlatforms,
      );
    }).toList();
  }
}
