import 'package:flutter/material.dart';

/// Displays a color picker from an array of [Color]s.
///
/// **Note**: Please don't repeat colors in the color list, this may cause UI
/// inconsistences :D
class ColorPicker extends StatefulWidget {
  final List<Color> colors;
  final Function(Color) onColorTap;
  final Color? initialSelectedcolor;

  const ColorPicker({
    Key? key,
    required this.colors,
    required this.onColorTap,
    this.initialSelectedcolor,
  }) : super(key: key);

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late Color _currentSelectedColor;

  @override
  void initState() {
    super.initState();
    _currentSelectedColor = widget.initialSelectedcolor ?? widget.colors[0];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 4,
          mainAxisSpacing: 3,
          crossAxisSpacing: 3,
          children: _colorsToTiles(),
        ),
      ),
    );
  }

  List<_ColorTile> _colorsToTiles() {
    return widget.colors.map((color) {
      return _ColorTile(
        onTileTap: (currentColor) {
          setState(() {
            _currentSelectedColor = color;
          });

          widget.onColorTap(currentColor);
        },
        isSelected: _currentSelectedColor.value == color.value,
        tileColor: color,
      );
    }).toList();
  }
}

class _ColorTile extends StatelessWidget {
  final Color tileColor;
  final Function(Color) onTileTap;
  final bool isSelected;

  const _ColorTile({
    required this.onTileTap,
    required this.tileColor,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTileTap(tileColor),
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Positioned(
            child: Container(
              width: 47,
              height: 47,
              color: tileColor,
            ),
          ),
          Positioned(
            width: 50,
            height: 50,
            child: isSelected
                ? Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: const Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}
