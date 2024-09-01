import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
      ),
      body: tabs[selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 4)),
        onPressed: () {  },
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

}
