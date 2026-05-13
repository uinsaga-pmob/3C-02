import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'custom_navbar.dart';
import 'pengaturan.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF161618),
      appBar: AppBar(
        title: const Text('TASKUY', style: TextStyle(color: Color(0XFF018592), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Color(0XFF018592)),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Pengaturan())),
          )
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(color: Color(0XFF018592), shape: BoxShape.circle),
              defaultTextStyle: TextStyle(color: Colors.white),
            ),
          ),
          const Spacer(),
        ],
      ),
      bottomNavigationBar: const CustomNavBar(selectedIndex: 0),
    );
  }
}