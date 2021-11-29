part of 'bloc_widgets.dart';

class TitleBlocWidget extends StatelessWidget {
  const TitleBlocWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final validator = context.select(
          (TaskFormBloc bloc) => bloc.state.title,
        );
        return TextFieldWidget(
          initialValue: validator.value,
          labelText: 'Insert title',
          onChanged: (value) {
            context.read<TaskFormBloc>().titleChanged(value);
          },
        );
      },
    );
  }
}
