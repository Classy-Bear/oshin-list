import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oshin_list/modules/task/bloc/bloc.dart';
import 'package:oshin_list/modules/task_information/bloc/task_form_bloc.dart';
import 'package:oshin_list/modules/task_information/widgets/bloc_widgets/bloc_widgets.dart';

class TaskInformationPage extends StatelessWidget {
  static const route = '/taskInformationPage';

  const TaskInformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TaskFormBloc>();
    final hasNoTask = bloc.state.isInitialState;
    final String title = hasNoTask ? "Create your task" : "Update your task";
    return _TaskInformationView(
      title: title,
      onSubmit: () {
        bloc.submitForm(
          (task) async {
            final bloc = context.read<TaskBloc>();
            if (hasNoTask) {
              await bloc.create(task);
            } else {
              await bloc.update(task);
            }
            Navigator.pop(context, task);
          },
        );
      },
    );
  }
}

class _TaskInformationView extends StatelessWidget {
  const _TaskInformationView({
    Key? key,
    required this.title,
    required this.onSubmit,
  }) : super(key: key);

  final String title;
  final void Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Oshin TaskForm"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
              const SizedBox(height: 50),
              const TitleBlocWidget(),
              const SizedBox(height: 20),
              const DescriptionBlocWidget(),
              const SizedBox(height: 20),
              const DatetimeBlocWidget(),
              const SizedBox(height: 40),
              const Text(
                "Choose a color",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              const SizedBox(height: 20),
              const ColorPickerBlocWidget(),
              const SizedBox(height: 10),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: ElevatedButton(
                    child: const Text(" SUBMIT"),
                    onPressed: onSubmit,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
