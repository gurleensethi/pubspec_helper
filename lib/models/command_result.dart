import 'package:pubspec_helper/enums/command_type.dart';

class CommandResult {
  final CommandType commandType;
  final String pubspecFilePath;

  CommandResult({
    this.commandType,
    this.pubspecFilePath,
  });
}
