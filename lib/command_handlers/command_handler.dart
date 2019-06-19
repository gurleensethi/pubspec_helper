import 'package:pubspec_helper/models/handler_util.dart';

abstract class CommandHandler<T extends HandlerUtil>{
  void handleCommand(T handlerUtil);
}