import 'package:pubspec_helper/helpers/pubspec_editor.dart';

abstract class CommandHandler {
  void handleCommand(PubspecEditor editor);
}