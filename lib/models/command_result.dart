import 'package:pubspec_helper/enums/command_type.dart';

class CommandResult {
  final CommandType commandType;
  final String pubspecFilePath;
  final String packageSearchTerm;

  CommandResult({
    this.commandType,
    this.pubspecFilePath,
    this.packageSearchTerm,
  });
}
