import 'package:pubspec_helper/command_handlers/command_handler.dart';
import 'package:pubspec_helper/helpers/network_helper.dart';
import 'package:pubspec_helper/helpers/pub_parsing_helper.dart';
import 'package:pubspec_helper/models/search_handler_options.dart';

class SearchHandler extends CommandHandler<SearchHandlerOptions> {
  @override
  void handleCommand(SearchHandlerOptions options) async {
    final pubParsingHelper = PubParsingHelper();

    final htmlContent = await NetworkHelper.fetchSearchPubWebsite(options.searchTerm);

    final packages = await pubParsingHelper.getPackagesListFromSearch(htmlContent);

    packages.forEach((package) {
      print(package.name);
    });
  }
}
