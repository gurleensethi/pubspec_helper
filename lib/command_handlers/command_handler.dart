import 'package:pubspec_helper/models/handler_options.dart';

abstract class CommandHandler<T extends HandlerOptions>{
  void handleCommand(T handlerOptions);
}