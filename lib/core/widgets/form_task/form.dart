import 'package:flutter/material.dart';
import 'package:oshin_list/core/widgets/form_task/date_picker.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:task_repository/task_repository.dart';

class FormTask extends StatelessWidget {
  const FormTask({Key? key, this.task}) : super(key: key);
  final Task? task;

  @override
  Widget build(BuildContext context) {
    late final String title;
    late final String btnText;
    final List<Map<String, dynamic>> type = [
      {'value': 'Work'},
      {'value': 'Study'},
      {'value': 'Family'},
    ];
    if (task != null) {
      title = "Update your task";
      btnText = "Update";
    } else {
      title = "Create your task";
      btnText = "Create";
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
          const SizedBox(
            height: 50,
          ),
          TextFormField(
            initialValue: task?.title,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Insert a title',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Insert a description',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          DatePicker(
            selectedDate: task?.date,
          ),
          const SizedBox(
            height: 20,
          ),
          SelectFormField(
            type: SelectFormFieldType.dropdown,
            initialValue: 'Work',
            items: type,
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Choose a color",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          // Color
          const SizedBox(
            height: 50,
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              child: ElevatedButton(
                child: Text(btnText),
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}
