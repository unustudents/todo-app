import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todos_app/app/core/utils/extensions.dart';

import '../../controllers/home_controller.dart';

class DoingList extends GetView<HomeController> {
  const DoingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.doingTodos.isEmpty && controller.doneTodos.isEmpty
          ? Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0.wp),
                  child: Image.asset(
                    'assets/todos.png',
                    fit: BoxFit.cover,
                    width: 50.0.wp,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                Text(
                  'Add Task',
                  style:
                      TextStyle(fontSize: 16.0.sp, fontWeight: FontWeight.bold),
                )
              ],
            )
          : ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                ...controller.doingTodos
                    .map((element) => Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 3.0.wp, horizontal: 8.0.wp),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: Checkbox(
                                    fillColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) => Colors.grey[200]),
                                    value: element['done'],
                                    onChanged: (val) {
                                      controller.doneTodo(element['title']);
                                    }),
                              ),
                              SizedBox(width: 4.0.wp),
                              Text(
                                element['title'],
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ))
                    .toList(),
                if (controller.doingTodos.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                    child: const Divider(thickness: 2),
                  ),
              ],
            ),
    );
  }
}
