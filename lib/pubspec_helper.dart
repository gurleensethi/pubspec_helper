import 'package:pubspec_helper/command_handlers/search_handler.dart';
import 'package:pubspec_helper/helpers/arguments_helper.dart';
import 'package:pubspec_helper/command_handlers/update_package_handler.dart';
import 'package:pubspec_helper/enums/command_type.dart';
import 'package:pubspec_helper/models/search_handler_options.dart';
import 'package:pubspec_helper/models/update_package_options.dart';

class PubspecHelper {
  /// Command line arguments from the user
  final List<String> args;
  final ArgumentsHelper _argumentsHelper;

  PubspecHelper(this.args) : _argumentsHelper = ArgumentsHelper(args);

  Future<void> execute() async {
    final commandResult = _argumentsHelper.buildCommand();

    switch (commandResult.commandType) {
      case CommandType.update:
        {
          final options = UpdatePackageOptions(commandResult.pubspecFilePath);
          UpdatePackageHandler().handleCommand(options);
          break;
        }
      case CommandType.search:
        {
          final options = SearchHandlerOptions(commandResult.packageSearchTerm);
          SearchHandler().handleCommand(options);
          break;
        }
    }
  }
}
