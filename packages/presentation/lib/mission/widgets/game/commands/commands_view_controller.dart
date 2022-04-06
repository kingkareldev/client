import 'package:flutter/material.dart';

enum NotifyEventType {
  save,
  run,
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
}
