import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/date_formatter.dart';
import 'package:todo_app/database_manager/model/task.dart';
import 'package:todo_app/database_manager/tasks_dao.dart';
import 'package:todo_app/providers/app_auth_provider.dart';
import 'package:todo_app/ui/widgets/custom_text_field.dart';

class EditTask extends StatefulWidget {
  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  var editedTaskTitleController = TextEditingController();
  var editedTaskDescController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AppAuthProvider>(context, listen: false);
    Task task = ModalRoute.of(context)!.settings.arguments as Task;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To Do List',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.all(25),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Edit Task',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                    SizedBox(
                      height: 30,
                    ),
                    CustomTextFormField(
                        hint: 'This is title',
                        keyboardType: TextInputType.text,
                        validator: (input) {
                          if (input == null || input.trim().isEmpty) {
                            return 'plz, enter task title';
                          }
                          return null;
                        },
                         initialValue: task.title,
                        onChanged: (input) {
                          task.title = input;
                        }),
                    CustomTextFormField(
                      hint: 'Task Details', keyboardType: TextInputType.text,
                      validator: (input) {
                        if (input == null || input.trim().isEmpty) {
                          return 'plz, enter task description';
                        }
                        return null;
                      },
                      // initialValue: task.description,
                      initialValue: task.description,
                      onChanged: (input) {
                        task.description = input;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "select date",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        showDatePicker(
                            context: context,
                            initialDate: DateUtils.dateOnly(
                                DateTime.fromMillisecondsSinceEpoch(
                                    task.taskDate!.millisecondsSinceEpoch)),
                            lastDate: DateTime.now().add(const Duration(days: 365)),
                            firstDate: DateTime.now(),
                        ).then((value) {
                          task.taskDate = Timestamp.fromDate(DateUtils.dateOnly(value!));
                          setState(() {

                          });
                        },);
                      },
                      child: Text(
                        formatDate(DateUtils.dateOnly(
                            DateTime.fromMillisecondsSinceEpoch(
                                task.taskDate!.millisecondsSinceEpoch))),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff707070)),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape:
                                  MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ))),
                          onPressed: () {
                            TasksDao.updateTask(task, authProvider.databaseUser!.id!);
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Save Changes',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
