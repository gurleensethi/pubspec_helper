import 'package:pubspec_helper/helpers/arguments_helper.dart';
import 'package:pubspec_helper/command_handlers/command_handler.dart';
import 'package:pubspec_helper/command_handlers/update_package_handler.dart';
import 'package:pubspec_helper/enums/command_type.dart';
import 'package:pubspec_helper/helpers/file_helper.dart';
import 'package:pubspec_helper/helpers/pubspec_editor.dart';

class PubspecHelper {
  /// Command line arguments from the user
  final List<String> args;
  final ArgumentsHelper _argumentsHelper;
  FileHelper _fileHelper;
  final Map<CommandType, CommandHandler> _commandHandlers = {
    CommandType.update: UpdatePackageHandler(),
  };

  PubspecHelper(this.args) : _argumentsHelper = ArgumentsHelper(args);

  Future<void> execute() async {
    final commandResult = _argumentsHelper.buildCommand();

    _fileHelper = FileHelper(filePath: commandResult.pubspecFilePath);

    await _fileHelper.validateFile(".yaml");

    final pubspecContent = PubspecEditor(fileHelper: _fileHelper);

    _commandHandlers[commandResult.commandType].handleCommand(pubspecContent);
  }
}
