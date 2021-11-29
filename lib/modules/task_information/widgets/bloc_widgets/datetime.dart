part of 'bloc_widgets.dart';

class DatetimeBlocWidget extends StatelessWidget {
  const DatetimeBlocWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final validator = context.select(
          (TaskFormBloc bloc) => bloc.state.isoDate,
        );
        final date = DateTime.tryParse(validator.value);
        return DatePicker(
          initialDate: date,
          onChanged: (value) => context
              .read<TaskFormBloc>()
              .dateTimeChanged(value.toIso8601String()),
        );
      },
    );
  }
}
