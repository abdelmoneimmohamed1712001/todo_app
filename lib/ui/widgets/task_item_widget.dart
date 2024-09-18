import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/routes_manager/routes_manager.dart';
import 'package:todo_app/core/utils/date_formatter.dart';
import 'package:todo_app/core/utils/dialog_utils.dart';
import 'package:todo_app/database_manager/model/task.dart';
import 'package:todo_app/database_manager/tasks_dao.dart';
import 'package:todo_app/providers/app_auth_provider.dart';

class TaskItemWidget extends StatefulWidget {
  Task task ;
  TaskItemWidget({super.key, required this.task});

  @override
  State<TaskItemWidget> createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5,),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: .3,
          motion: StretchMotion(),
          children: [
            SlidableAction(onPressed: (context) {
              deleteTask();

            },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'delete',
            )
          ],
        ),
        endActionPane: ActionPane(
          extentRatio: .3,
          motion: StretchMotion(),
          children: [
            SlidableAction(

              // An action can be bigger than the others.
              flex: 1,
              onPressed: (context) {
                print(widget.task.taskDate);
                Navigator.pushNamed(context, AppRoutes.editTask,arguments: widget.task);
              },
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),


          ],
        ),


        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: 3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor),
                ),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.task.title??'',style: Theme.of(context).textTheme.bodyLarge),
                    SizedBox(height: 5,),
                    Text(widget.task.description??'',style: Theme.of(context).textTheme.bodyMedium),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Icon(Icons.date_range),
                        SizedBox(width: 5,),
                        Text(formatDate(widget.task.taskDate!.toDate())??''),
                      ],
                    ),

                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: () {

                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 21),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColor),
                      child: const Icon(
                        (Icons.check),
                        color: Colors.white,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


void deleteTask() {
    var authProvider = Provider.of<AppAuthProvider>(context,listen: false);
  DialogUtils.showMessageDialog(context,message: 'Are U sue U want to delete task',
      posActionTitle: 'Confirm',posAction: () async{

        await TasksDao.deleteTask(authProvider.databaseUser!.id!, widget.task.id!);

      },negActionTitle: 'Cancel');



}


void editTask() {
  Navigator.pushNamed(context, AppRoutes.editTask,arguments: widget.task);

}}