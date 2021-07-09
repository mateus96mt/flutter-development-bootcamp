import 'package:flutter/material.dart';

import 'task.model.dart';

class TaskData extends ChangeNotifier {
  List<Task> tasks = [
    for (int i = 0; i < 10; i++) Task(name: 'test $i'),
  ];

  int get tasksCount {
    return tasks.length;
  }

  void add(Task task) {
    tasks.add(task);
    notifyListeners();
  }

  void removeAt(int index) {
    tasks.removeAt(index);
    notifyListeners();
  }

  void clear() {
    tasks.clear();
    notifyListeners();
  }

  void changeTaskState(int index) {
    tasks[index].changeState();
    notifyListeners();
  }
}
