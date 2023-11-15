import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/new_task_screen.dart';
import 'package:task_manager/ui/screens/task_canceled_screen.dart';
import 'package:task_manager/ui/screens/task_completed_screen.dart';
import 'package:task_manager/ui/screens/task_inprogress_screen.dart';

class MainBottomNavbarScreen extends StatefulWidget {
  const MainBottomNavbarScreen({super.key});

  @override
  State<MainBottomNavbarScreen> createState() => _MainBottomNavbarScreenState();
}

class _MainBottomNavbarScreenState extends State<MainBottomNavbarScreen> {

  int _selectedIndex = 0;
 final List<Widget> _screens = const [
    NewTaskScreen(),
    TaskInprogressScreen(),
    TaskCompletedScreen(),
    TaskCanceledScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index){
          _selectedIndex = index;
          setState(() {});
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.pages), label: "New"),
          BottomNavigationBarItem(icon: Icon(Icons.change_circle_outlined), label: "In Progress"),
          BottomNavigationBarItem(icon: Icon(Icons.incomplete_circle_outlined), label: "Completed"),
          BottomNavigationBarItem(icon: Icon(Icons.cancel_presentation_outlined), label: "Cancelled"),
        ],
      ),
    );
  }
}
