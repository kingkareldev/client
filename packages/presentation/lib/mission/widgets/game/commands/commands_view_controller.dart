import 'package:flutter/material.dart';

enum NotifyEventType {
  save,
  run,
  reset,
}

class CommandsViewController extends ChangeNotifier {
  NotifyEventType type = NotifyEventType.save;

  void save() {
    type = NotifyEventType.save;
    notifyListeners();
  }

  void run() {
    type = NotifyEventType.run;
    notifyListeners();
  }

  void reset() {
    type = NotifyEventType.reset;
    notifyListeners();
  }
}
