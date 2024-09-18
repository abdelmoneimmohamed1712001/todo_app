import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/routes_manager/routes_manager.dart';
import 'package:todo_app/core/utils/dialog_utils.dart';
import 'package:todo_app/providers/app_auth_provider.dart';
import 'package:todo_app/ui/home/add_task_bottom_sheet.dart';
import 'package:todo_app/ui/home/tabs/settings_tab/settings_tab.dart';
import 'package:todo_app/ui/home/tabs/tasks_tab/tasks_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AppAuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
        actions: [
          IconButton(
            onPressed: () {
              DialogUtils.showMessageDialog(context,message: 'Are you sure you want to sign out',
              posActionTitle: 'Confirm',
              posAction:() {
                logOut();
                Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
              },
              negActionTitle: 'Cancel'
              );

            },
            icon: Icon(Icons.logout),
              )
        ],
      ),
      body: tabs[selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 4)),
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child : Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        child: BottomNavigationBar(
          onTap: (index) {
            selectedIndex = index;
            setState(() {

            });
          },
          currentIndex: selectedIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list),label: 'Task'),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
          ],

        ),
      ),
    );
  }
  var tabs = [TasksTab(), SettingsTab()];



void logOut() {
  var authProvider  =Provider.of<AppAuthProvider>(context,listen: false);
  authProvider.signOut();
}


void showAddTaskBottomSheet() {
  showModalBottomSheet(context: context, builder: (context) => AddTaskBottomSheet(),shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.only(topRight: Radius.circular(18),topLeft: Radius.circular(18))
  ));
}}
