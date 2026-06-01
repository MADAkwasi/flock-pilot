import 'package:flutter/foundation.dart';

class GoRouterRefresh extends ChangeNotifier {
  GoRouterRefresh(Stream stream) {
    stream.listen((_) => notifyListeners());
  }
}
