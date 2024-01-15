import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePickerTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final Function(DateTime)? onDateSelected;

  const DatePickerTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.onDateSelected,
  }) : super(key: key);

  @override
  _DatePickerTextFieldState createState() => _DatePickerTextFieldState();
}

class _DatePickerTextFieldState extends State<DatePickerTextField> {
  Future<void> _selectDate(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          child: CupertinoDatePicker(
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (DateTime newDateTime) {
              setState(() {
                widget.controller.text =
                    "${newDateTime.day}/${newDateTime.month}/${newDateTime.year}";
              });
              widget.onDateSelected?.call(newDateTime);
            },
            mode: CupertinoDatePickerMode.date,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.labelText,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 45.0,
            child: TextField(
              controller: widget.controller,
              readOnly: true,
              onTap: () => _selectDate(context),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                suffixIcon: Icon(Icons.calendar_today),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
