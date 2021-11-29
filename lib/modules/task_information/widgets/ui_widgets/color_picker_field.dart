part of 'ui_widgets.dart';

class ColorPickerUIWidget extends StatelessWidget {
  const ColorPickerUIWidget({
    Key? key,
    required this.onColorTap,
    required this.colorValue,
  }) : super(key: key);

  final Function(Color) onColorTap;
  final int colorValue;

  @override
  Widget build(BuildContext context) {
    return ColorPickerWidget(
      width: 300,
      height: 150,
      colors: const [
        Color(pastelPink),
        Color(lightBrown),
        Color(purple),
        Color(green)
      ],
      onColorTap: onColorTap,
      initialSelectedcolor: Color(colorValue),
    );
  }
}
