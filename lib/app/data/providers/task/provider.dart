import 'dart:convert';

import 'package:get/get.dart';
import '../../service/storage/services.dart';
import '../../../core/utils/keys.dart';
import '../../models/task.dart';

class TaskProvider {
  final _storage = Get.find<StorageService>();
  // {'task':[{'title':'Work','color':'#ff123456','icon':0xe123}]}

  List<Task> readTasks() {
    var tasks = <Task>[];
    jsonDecode(_storage.read(taskKey).toString()).forEach(
      (e) => tasks.add(Task.fromJson(e)),
    );
    return tasks;
  }

  void writeTasks(List<Task> task) {
    _storage.write(taskKey, jsonEncode(task));
  }
}
