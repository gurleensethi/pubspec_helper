import 'package:pubspec_helper/helpers/arguments_helper.dart';
import 'package:pubspec_helper/command_handlers/command_handler.dart';
import 'package:pubspec_helper/command_handlers/update_package_handler.dart';
import 'package:pubspec_helper/enums/command_type.dart';
import 'package:pubspec_helper/helpers/file_helper.dart';
import 'package:pubspec_helper/helpers/pubspec_editor.dart';
import 'package:pubspec_helper/models/handler_util.dart';

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
          final _fileHelper =
              FileHelper(filePath: commandResult.pubspecFilePath);
          await _fileHelper.validateFile(".yaml");
          final pubspecContent = PubspecEditor(fileHelper: _fileHelper);
          UpdatePackageHandler().handleCommand(pubspecContent);
          break;
        }
      case CommandType.search:
        {
          break;
        }
    }
  }
}
