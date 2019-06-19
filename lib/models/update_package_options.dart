import 'package:pubspec_helper/models/handler_options.dart';

class UpdatePackageOptions extends HandlerOptions {
  final String pubspecFilePath;

  UpdatePackageOptions(this.pubspecFilePath);
}