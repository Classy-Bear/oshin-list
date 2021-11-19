import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oshin_list/core/widgets/color_picker/color_picker_widget.dart';
import 'package:oshin_list/core/widgets/date_picker/date_picker_widget.dart';
import 'package:oshin_list/core/widgets/text_field/text_field_widget.dart';
import 'package:oshin_list/helper/color_helper.dart';
import 'package:oshin_list/helper/type.dart';
import 'package:oshin_list/modules/task/bloc/bloc.dart';
import 'package:oshin_list/modules/task_information/bloc/task_form_bloc.dart';
import 'package:task_repository/task_repository.dart';

class FormTaskWidget extends StatefulWidget {
  final Task? task;

  const FormTaskWidget({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<FormTaskWidget> createState() => _FormTaskWidgetState();
}

class _FormTaskWidgetState extends State<FormTaskWidget> {
  @override
  void initState() {
    super.initState();
    final task = widget.task;
    if (task != null) {
      context.read<TaskFormBloc>().titleChanged(task.title ?? '');
      context.read<TaskFormBloc>().descriptionChanged(task.description ?? '');
      context.read<TaskFormBloc>().colorChanged(task.color!);
      context.read<TaskFormBloc>().typeChanged(task.type ?? TaskType.work);
      context
          .read<TaskFormBloc>()
          .dateTimeChanged(task.date?.toIso8601String() ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskFormBloc, TaskFormState>(
      builder: (context, state) {
        return _FormTask(
          task: widget.task,
          onDateChanged: (date) {
            context
                .read<TaskFormBloc>()
                .dateTimeChanged(date.toIso8601String());
          },
          onDropdownChanged: (string) {
            context.read<TaskFormBloc>().typeChanged(strAsTaskType(string));
          },
          onColorChanged: (color) {
            int colorRange1 = colorRange(color);
            context.read<TaskFormBloc>().colorChanged(colorRange1);
          },
          onFormSubmit: () {
            context.read<TaskFormBloc>().submitForm(
              (task) async {
                if (this.widget.task == null) {
                  await context.read<TaskBloc>().create(task);
                  Navigator.pop(context);
                  return;
                }
                await context.read<TaskBloc>().update(task);
                Navigator.pop(context);
              },
              task: widget.task,
            );
          },
          onDescriptionChanged: (value) {
            context.read<TaskFormBloc>().descriptionChanged(value);
          },
          onTitleChanged: (value) {
            context.read<TaskFormBloc>().titleChanged(value);
          },
        );
      },
    );
  }
}

class _FormTask extends StatelessWidget {
  final Task? task;
  final void Function(String) onTitleChanged;
  final void Function(String) onDescriptionChanged;
  final void Function(DateTime) onDateChanged;
  final void Function(String) onDropdownChanged;
  final void Function(Color) onColorChanged;
  final void Function() onFormSubmit;

  const _FormTask({
    Key? key,
    this.task,
    required this.onDateChanged,
    required this.onDropdownChanged,
    required this.onColorChanged,
    required this.onFormSubmit,
    required this.onTitleChanged,
    required this.onDescriptionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final String title;
    late final String btnText;
    const List<Color> colorList = [
      Color(0xffF5B7B1),
      Color(0xff997070),
      Color(0xff663399),
      Color(0xff008000)
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
                context.read<TaskFormBloc>().colorChanged(colorRange(color));
              },
              initialSelectedcolor: Color(task?.selectedColor ?? 0),
            ),
            const SizedBox(height: 10),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: ElevatedButton(
                  child: Text(btnText),
                  onPressed: () => onFormSubmit(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
