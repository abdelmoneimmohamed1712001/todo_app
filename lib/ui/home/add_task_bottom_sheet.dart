import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/date_formatter.dart';
import 'package:todo_app/core/utils/dialog_utils.dart';
import 'package:todo_app/database_manager/model/task.dart';
import 'package:todo_app/database_manager/tasks_dao.dart';
import 'package:todo_app/providers/app_auth_provider.dart';
import 'package:todo_app/ui/widgets/custom_text_field.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var taskTitleController = TextEditingController();
  var taskDescController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 14,
            ),
            Text(
              'Add new Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff383838)),
            ),
            SizedBox(
              height: 14,
            ),
            CustomTextFormField(
              hint: 'Enter your Task title',
              controller: taskTitleController,
              keyboardType: TextInputType.text,
              validator: (input) {
                if (input == null || input.trim().isEmpty) {
                  return 'plz, enter task title';
                }
                return null;
              },
            ),
            CustomTextFormField(
              hint: 'Enter your Task details',
              controller: taskDescController,
              keyboardType: TextInputType.text,
              validator: (input) {
                if (input == null || input.trim().isEmpty) {
                  return 'plz, enter task description';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Select Date',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            InkWell(
              onTap: () {
                chooseTaskDate();
              },
              child: Text(
                formatDate(finalSelectedDate),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff707070)),
              ),
            ),

            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  createTask();
                },
                child: Text(
                  'Add Task',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  var finalSelectedDate = DateTime.now();
  var finalSelectedTime = TimeOfDay.now();

  void chooseTaskDate() async {
    DateTime? userSelectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (userSelectedDate != null) {
      finalSelectedDate = userSelectedDate;
      setState(() {});
    }
  }


  void createTask() async {
    var authProvider = Provider.of<AppAuthProvider>(context, listen: false);
    if (formKey.currentState?.validate() == false) return;

    int taskTimeInMinutes = finalSelectedTime.hour * 60 + finalSelectedTime.minute;

    Task task = Task(
      id: authProvider.databaseUser!.id!,
      title: taskTitleController.text,
      description: taskDescController.text,
      taskDate: Timestamp.fromMillisecondsSinceEpoch(
          finalSelectedDate.millisecondsSinceEpoch), // 1 hr = 60 min * 60 sec * 1000 ms
     );
    DialogUtils.showLoadingDialog(context, 'Adding Task...');
    await TasksDao.addTask(task, authProvider.databaseUser!.id!);
    DialogUtils.hideDialog(context);
    DialogUtils.showMessageDialog(
      context,
      message: 'Task Added Successfully',
      posActionTitle: 'ok',
      posAction: () {
        Navigator.pop(context);
      },
    );
  }



}