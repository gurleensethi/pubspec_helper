import 'package:pubspec_helper/pubspec_helper.dart';

main(List<String> arguments) async {
  try {
    await PubspecHelper(arguments).execute();
  } catch (error, stackTrace) {
    print(error);
    print("\n\nStackTrace:");
    print(stackTrace);
  }
}
