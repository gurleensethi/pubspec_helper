enum CommandType { update, search }

class CommandTypeUtil {
  static CommandType fromString(String name) {
    final commandsAsStrings = CommandType.values
        .map((command) => command.toString().split(".")[1])
        .toList();

    final commandIndex = commandsAsStrings.indexOf(name);

    // Wrong command
    if (commandIndex == -1) {
      return null;
    }

    return CommandType.values[commandIndex];
  }

  static String asString(CommandType type) {
    return type.toString().split(".")[1];
  }
}
