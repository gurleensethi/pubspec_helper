import 'package:args/args.dart';
import 'package:pubspec_helper/enums/command_type.dart';
import 'package:pubspec_helper/models/command_result.dart';

class ArgumentsHelper {
  final List<String> args;
  final ArgParser _argParser = ArgParser();
  ArgResults _argResults;

  ArgumentsHelper(this.args) {
    _setUpArgParser();
  }

  /// Initialise the arguments
  void _setUpArgParser() {
    final updateParser =
        _argParser.addCommand(CommandTypeUtil.asString(CommandType.update));

    updateParser.addOption("file", abbr: "f");

    final searchParser =
        _argParser.addCommand(CommandTypeUtil.asString(CommandType.search));

    searchParser.addOption(
      "term",
      valueHelp: "Search term",
      abbr: "t",
      help: "The search term that will be searched on https://pub.dev",
    );

    _argResults = _argParser.parse(args);
  }

  CommandResult buildCommand() {
    final command = _argResults.command;

    if (command == null) {
      throw Exception("Zero or Invalid command passed!");
    }

    final commandType = CommandTypeUtil.fromString(command.name);
    String filePath;
    String packageSearchTerm;

    switch (commandType) {
      case CommandType.update:
        {
          // Check if a file name is provided
          if (command['file'] == null) {
            throw Exception("Please provide a file using -f option.");
          }
          filePath = command['file'];
          break;
        }
      case CommandType.search:
        {
          if (command['term'] == null) {
            throw Exception("Please provide a search term using -t option.\n"
                "For example:\n"
                "\tdartaotrumtime pubspec_helper.dart.aot search -t firebase");
          }
          packageSearchTerm = command['term'];
          break;
        }
    }

    return CommandResult(
      commandType: commandType,
      pubspecFilePath: filePath,
      packageSearchTerm: packageSearchTerm,
    );
  }
}
