part of 'bloc_widgets.dart';

class DescriptionBlocWidget extends StatelessWidget {
  const DescriptionBlocWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final validator = context.select(
          (TaskFormBloc bloc) => bloc.state.description,
        );
        return TextFieldWidget(
          initialValue: validator.value,
          labelText: 'Insert a description',
          onChanged: (value) {
            context.read<TaskFormBloc>().descriptionChanged(value);
          },
        );
      },
    );
  }
}
