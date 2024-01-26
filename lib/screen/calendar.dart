import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tobeto_app/widget/calendar_widget/calendar_model.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<CalendarEvent> _events = [];

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('calendar').get();
    setState(() {
      _events = snapshot.docs
          .map((doc) => CalendarEvent.fromFirestore(doc))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime(1990),
            lastDay: DateTime(2050),
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => _events.any((event) => isSameDay(day, event.date)),
            onDaySelected: (selectedDay, focusedDay) {
              _focusedDay = focusedDay;
              _selectedDay = selectedDay;
              setState(() {});
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              markersMaxCount: 1,
            ),
            calendarBuilders: CalendarBuilders(
              selectedBuilder: (context, date, events) => Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  date.day.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              todayBuilder: (context, date, events) => Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  date.day.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: _buildEvents(),
          ),
        ],
      ),
    );
  }

  Widget _buildEvents() {
    if (_selectedDay == null) {
      _events.sort((a, b) => a.date!.compareTo(b.date!));
      return ListView.builder(
        itemCount: _events.length,
        itemBuilder: (context, index) {
          final event = _events[index];
          return ListTile(
            title: Text('Eğitim: ${event.education ?? ''}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Eğitmen: ${event.instructor ?? ''}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Tarih: ${event.date?.day}/${event.date?.month}/${event.date?.year}',
                ),
              ],
            ),
          );
        },
      );
    } else {
      final selectedEvents = _events
          .where((event) => isSameDay(_selectedDay, event.date))
          .toList();

      selectedEvents.sort((a, b) => a.date!.compareTo(b.date!));

      return ListView.builder(
        itemCount: selectedEvents.length,
        itemBuilder: (context, index) {
          final event = selectedEvents[index];
          return ListTile(
            title: Text('Eğitim: ${event.education ?? ''}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Eğitmen: ${event.instructor ?? ''}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Tarih: ${event.date?.day}/${event.date?.month}/${event.date?.year}',
                ),
              ],
            ),
          );
        },
      );
    }
  }
}
