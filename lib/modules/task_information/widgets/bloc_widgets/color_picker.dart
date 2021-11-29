part of 'bloc_widgets.dart';

class ColorPickerBlocWidget extends StatelessWidget {
  const ColorPickerBlocWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final validator = context.select(
          (TaskFormBloc bloc) => bloc.state.color,
        );
        return ColorPickerUIWidget(
          onColorTap: (color) {
            context.read<TaskFormBloc>().colorChanged(color.colorRange);
          },
          colorValue: validator.value,
        );
      },
    );
  }
}
