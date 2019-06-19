import 'package:pubspec_helper/command_handlers/command_handler.dart';
import 'package:pubspec_helper/models/search_handler_options.dart';

class SearchHandler extends CommandHandler<SearchHandlerOptions> {
  @override
  void handleCommand(SearchHandlerOptions options) {
    print(options.searchTerm);
  }
}
