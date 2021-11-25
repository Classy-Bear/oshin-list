import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oshin_list/core/widgets/color_picker/color_picker_widget.dart';
import 'package:oshin_list/core/widgets/date_picker/date_picker_widget.dart';
import 'package:oshin_list/core/widgets/text_field/text_field_widget.dart';
import 'package:oshin_list/helper/color_helper.dart';
import 'package:oshin_list/modules/task/bloc/bloc.dart';
import 'package:oshin_list/modules/task_information/bloc/task_form_bloc.dart';
import 'package:task_repository/task_repository.dart';

class FormTaskWidget extends StatelessWidget {
  final Task? task;

  const FormTaskWidget({
    Key? key,
    required this.task,
  }) : super(key: key);

  static const List<Color> colorList = [
    Color(pastelPink),
    Color(lightBrown),
    Color(purple),
    Color(green)
  ];

  @override
  Widget build(BuildContext context) {
    final String title = task != null ? "Update your task" : "Create your task";

    return BlocBuilder<TaskFormBloc, TaskFormState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
                const SizedBox(height: 50),
                TextFieldWidget(
                  initialValue: task?.title ?? '',
                  labelText: 'Insert title',
                  onChanged: (value) {
                    context.read<TaskFormBloc>().titleChanged(value);
                  },
                ),
                const SizedBox(height: 20),
                TextFieldWidget(
                  initialValue: task?.description ?? '',
                  labelText: 'Insert a description',
                  onChanged: (value) {
                    context.read<TaskFormBloc>().descriptionChanged(value);
                  },
                ),
                const SizedBox(height: 20),
                DatePicker(
                  initialDate: task?.date,
                  onChanged: (value) => context
                      .read<TaskFormBloc>()
                      .dateTimeChanged(value.toIso8601String()),
                ),
                const SizedBox(height: 40),
                const Text(
                  "Choose a color",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                ColorPickerWidget(
                  width: 300,
                  height: 150,
                  colors: colorList,
                  onColorTap: (color) {
                    context.read<TaskFormBloc>().colorChanged(color.colorRange);
                  },
                  initialSelectedcolor: Color(task?.selectedColor ?? 0),
                ),
                const SizedBox(height: 10),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: ElevatedButton(
                      child: const Text(" SUBMIT"),
                      onPressed: () {
                        context.read<TaskFormBloc>().submitForm(
                          (task) async {
                            if (this.task == null) {
                              await context.read<TaskBloc>().create(task);
                              Navigator.pop(context);
                              return;
                            }
                            await context.read<TaskBloc>().update(task);
                            Navigator.pop(context);
                          },
                          task: task,
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
