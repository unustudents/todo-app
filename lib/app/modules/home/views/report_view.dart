import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todos_app/app/core/utils/extensions.dart';
import 'package:todos_app/app/core/values/colors.dart';

import '../controllers/home_controller.dart';

class ReportView extends GetView<HomeController> {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          var creatTasks = controller.getTotalTask();
          var completTask = controller.getTotalDoneTask();
          var liveTask = creatTasks - completTask;
          var percent = (completTask / creatTasks * 100).toStringAsFixed(0);
          return ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(4.0.wp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Report',
                      style: TextStyle(
                          fontSize: 24.0.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4.0.wp),
                    Text(
                      DateFormat.yMMMMd().format(DateTime.now()),
                      style: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
                    ),
                    SizedBox(height: 3.0.wp),
                    const Divider(thickness: 2),
                    SizedBox(height: 3.0.wp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatus(Colors.green, liveTask, 'Live Tasks'),
                        _buildStatus(Colors.orange, completTask, 'Completed'),
                        _buildStatus(Colors.blue, creatTasks, 'Ceated'),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 8.0.wp),
              UnconstrainedBox(
                child: SizedBox(
                  width: 70.0.wp,
                  height: 70.0.wp,
                  child: CircularStepProgressIndicator(
                    totalSteps: creatTasks == 0 ? 1 : creatTasks,
                    currentStep: completTask,
                    stepSize: 25,
                    selectedColor: green,
                    unselectedColor: Colors.grey[200],
                    padding: 0,
                    width: 150,
                    height: 150,
                    selectedStepSize: 22,
                    roundedCap: (a, b) => true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${creatTasks == 0 ? 0 : percent} %',
                          style: TextStyle(
                              fontSize: 20.0.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 1.0.wp),
                        Text(
                          'Efficiency',
                          style: TextStyle(
                              fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  _buildStatus(Color color, int number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 3.0.wp,
          width: 3.0.wp,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 0.5.wp, color: color),
          ),
        ),
        SizedBox(width: 3.0.wp),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$number',
              style: TextStyle(fontSize: 16.0.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2.0.wp),
            Text(
              text,
              style: TextStyle(fontSize: 12.0.sp, color: Colors.grey),
            )
          ],
        )
      ],
    );
  }
}
