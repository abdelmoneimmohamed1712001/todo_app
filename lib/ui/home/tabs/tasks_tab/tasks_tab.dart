import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/database_manager/tasks_dao.dart';
import 'package:todo_app/providers/app_auth_provider.dart';
import 'package:todo_app/ui/widgets/task_item_widget.dart';

class TasksTab extends StatefulWidget {
  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AppAuthProvider>(context);
    return authProvider.databaseUser == null? const Center(child: CircularProgressIndicator(),) : Column(
      children: [
        Container(
            padding: EdgeInsets.all(10),
            child: Text(
              'Hello, ${authProvider.databaseUser?.fullName}',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor),
            )),
        EasyDateTimeLine(
          initialDate: DateTime.now(),
          onDateChange: (datetime) {

            setState(() {
              selectedDate = datetime;
            });
          },
          headerProps: const EasyHeaderProps(
            monthPickerType: MonthPickerType.switcher,
            dateFormatter: DateFormatter.fullDateDMY(),
          ),
          dayProps: const EasyDayProps(
            dayStructure: DayStructure.dayStrDayNum,
            activeDayStyle: DayStyle(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Color(0xFF5D9CEC),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        StreamBuilder(
          stream: TasksDao.getAllTasksRealTime(authProvider.databaseUser!.id!,selectedDate),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            var taskList = snapshot.data?.docs.map((docSnapshot) => docSnapshot.data()).toList();
            return Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) =>
                  TaskItemWidget(task: taskList![index]),
              itemCount: taskList?.length ?? 0,
            ));
          },
        )
      ],
    );
  }
}
