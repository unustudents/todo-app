import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'widgets_detail/done_list.dart';
import 'widgets_detail/doing_list.dart';
import '../../../core/utils/extensions.dart';
import '../controllers/home_controller.dart';

class DetailView extends GetView<HomeController> {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    var task = controller.task.value!;
    var color = HexColor.fromHex(task.color);

    return PopScope(
      onPopInvoked: (a) async => false,
      child: Scaffold(
        body: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(3.0.wp),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new),
                      onPressed: () {
                        Get.back();
                        controller.updateTodos();
                        controller.changeTask(null);
                        controller.editC.clear();
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
                child: Row(
                  children: [
                    Icon(
                      IconData(task.icon, fontFamily: 'MaterialIcons'),
                      color: color,
                    ),
                    SizedBox(width: 3.0.wp),
                    Text(
                      task.title,
                      style: TextStyle(
                          fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Obx(
                () {
                  var totalTodos = controller.doingTodos.length +
                      controller.doneTodos.length;
                  return Padding(
                    padding: EdgeInsets.fromLTRB(16.0.wp, 3.0.wp, 16.0.wp, 0),
                    child: Row(
                      children: [
                        Text(
                          '$totalTodos Tasks',
                          style:
                              TextStyle(fontSize: 12.0.sp, color: Colors.grey),
                        ),
                        SizedBox(width: 3.0.wp),
                        Expanded(
                          child: StepProgressIndicator(
                            totalSteps: totalTodos == 0 ? 1 : totalTodos,
                            currentStep: controller.doneTodos.length,
                            size: 5,
                            padding: 0,
                            selectedGradientColor: LinearGradient(
                              colors: [color.withOpacity(0.5), color],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            unselectedGradientColor: LinearGradient(
                              colors: [Colors.grey[300]!, Colors.grey[300]!],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 5.0.wp, vertical: 2.0.wp),
                child: TextFormField(
                  controller: controller.editC,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                    prefixIcon: Icon(
                      Icons.check_box_outline_blank_rounded,
                      color: Colors.grey[400]!,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          var success =
                              controller.addTodo(controller.editC.text);
                          if (success) {
                            EasyLoading.showSuccess(
                                'Item berhasil ditambahkan');
                          } else {
                            EasyLoading.showError('Item sudah ada');
                          }
                          controller.editC.clear();
                        }
                      },
                      icon: const Icon(Icons.done),
                    ),
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Tolong masukan todo';
                    }
                    return null;
                  },
                ),
              ),
              const DoingList(),
              const DoneList(),
            ],
          ),
        ),
      ),
    );
  }
}
