import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../core/utils/extensions.dart';
import '../../../../core/values/colors.dart';
import '../../../../data/models/task.dart';
import '../../../../widgets/icons.dart';
import '../../controllers/home_controller.dart';

class AddCard extends GetView<HomeController> {
  const AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (Get.width - 12.0.wp) / 2,
      height: (Get.width - 12.0.wp) / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
            titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
            radius: 5,
            title: 'Task Type',
            content: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(3.0.wp),
                    child: TextFormField(
                      controller: controller.editC,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Tolong masukan judul';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0.wp),
                    child: Wrap(
                      spacing: 2.0.wp,
                      runSpacing: 2.0.wp,
                      children: getIcon()
                          .map(
                            (e) => Obx(() {
                              final i = getIcon().indexOf(e);
                              return ChoiceChip(
                                selectedColor: Colors.grey[200],
                                pressElevation: 0,
                                backgroundColor: Colors.white,
                                shape: const StadiumBorder(),
                                side: BorderSide.none,
                                showCheckmark: false,
                                label: e,
                                selected: controller.chipIndex.value == i,
                                onSelected: (bool selected) => controller
                                    .chipIndex.value = selected ? i : 0,
                              );
                            }),
                          )
                          .toList(),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: const Size(150, 40),
                    ),
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        int icon = getIcon()[controller.chipIndex.value]
                            .icon!
                            .codePoint;
                        String color = getIcon()[controller.chipIndex.value]
                            .color!
                            .toHex();
                        var task = Task(
                            title: controller.editC.text,
                            icon: icon,
                            color: color);
                        Get.back();
                        controller.addTask(task)
                            ? EasyLoading.showSuccess('Create Success')
                            : EasyLoading.showError('Duplicated Task');
                      }
                    },
                    child: const Text('Konfirmasi'),
                  ),
                ],
              ),
            ),
          );
          controller.editC.clear();
          controller.changeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              size: 10.0.wp,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
