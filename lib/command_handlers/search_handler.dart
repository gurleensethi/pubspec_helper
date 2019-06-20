import 'package:pubspec_helper/command_handlers/command_handler.dart';
import 'package:pubspec_helper/helpers/network_helper.dart';
import 'package:pubspec_helper/helpers/pub_parsing_helper.dart';
import 'package:pubspec_helper/models/package_model.dart';
import 'package:pubspec_helper/models/search_handler_options.dart';
import 'package:ansicolor/ansicolor.dart';

class SearchHandler extends CommandHandler<SearchHandlerOptions> {
  @override
  void handleCommand(SearchHandlerOptions options) async {
    final pubParsingHelper = PubParsingHelper();

    final htmlContent =
        await NetworkHelper.fetchSearchPubWebsite(options.searchTerm);

    final packages =
        await pubParsingHelper.getPackagesListFromSearch(htmlContent);

    packages.forEach(_prettyPrintPakcage);
  }

  void _prettyPrintPakcage(PacakgeModel package) {
    final greenPen = AnsiPen()..green();
    final bluePen = AnsiPen()..blue();
    final cyanPen = AnsiPen()..cyan();
    final yellowPen = AnsiPen()..yellow();
    final grayPen = AnsiPen()..gray();

    final packageVersion = package.score != null ? "Score: ${package.score}\n" : "";
    final lastUpdated = package.lastUpdated != null ? "Updated: ${package.lastUpdated}\n" : "";
    final supportedPlatforms = package.supportedPlatforms.isNotEmpty ? "${package.supportedPlatforms.join(", ")}\n" : "";

    String formattedString =
        "${greenPen(package.name)} ${bluePen(package.version ?? "")}\n"
        "${yellowPen(packageVersion)}"
        "${package.description}\n"
        "${grayPen(lastUpdated)}"
        "${cyanPen(supportedPlatforms)}";

    print(formattedString);
  }
}
