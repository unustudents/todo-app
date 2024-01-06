import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/extensions.dart';
import '../../controllers/home_controller.dart';

class DoneList extends GetView<HomeController> {
  const DoneList({super.key});

  @override
  Widget build(BuildContext context) {
    var task = controller.task.value!;
    var color = HexColor.fromHex(task.color);

    return Obx(
      () => controller.doneTodos.isNotEmpty
          ? ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 5.0.wp, vertical: 2.0.wp),
                  child: Text(
                    'Completed (${controller.doneTodos.length}) tasks',
                    style: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
                  ),
                ),
                ...controller.doneTodos
                    .map((element) => Dismissible(
                          key: ObjectKey(element),
                          direction: DismissDirection.endToStart,
                          onDismissed: (a) =>
                              controller.deleteDoneTodo(element),
                          background: Container(
                            color: Colors.red.withOpacity(0.8),
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: 5.0.wp),
                              child:
                                  const Icon(Icons.delete, color: Colors.white),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0.wp, vertical: 3.0.wp),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Icon(Icons.done, color: color),
                                ),
                                SizedBox(width: 3.0.wp),
                                Text(
                                  element['title'],
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      decoration: TextDecoration.lineThrough),
                                )
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ],
            )
          : const SizedBox(),
    );
  }
}
