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
    _argParser.addOption("file", abbr: "f");

    final updateParser =
        _argParser.addCommand(CommandTypeUtil.asString(CommandType.update));

    updateParser.addFlag("n", defaultsTo: false);

    _argResults = _argParser.parse(args);
  }

  CommandResult buildCommand() {
    final command = _argResults.command;

    if (command == null) {
      throw Exception("Zero or Invalid command passed!");
    }

    // Check if a file name is provided
    if (_argResults['file'] == null) {
      throw Exception("Please provide a file using -f option.");
    }

    final commandType = CommandTypeUtil.fromString(command.name);
    final filePath = _argResults['file'];

    return CommandResult(
      commandType: commandType,
      pubspecFilePath: filePath,
    );
  }
}
