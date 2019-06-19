import 'package:pubspec_helper/models/handler_util.dart';

class SearchHelper extends HandlerUtil {
  final String searchTerm;

  SearchHelper(this.searchTerm) : assert(searchTerm != null);
}
