import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BtnColorPicker extends ConsumerWidget {
  final Color selectedColor;
  final Function(Color) selectedColorCallback;

  const BtnColorPicker({
    super.key,
    required this.selectedColor,
    required this.selectedColorCallback,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Function to open the color picker dialog
    Future<void> openColorPicker() async {
      await ColorPicker(
        color: selectedColor,
        onColorChanged: selectedColorCallback,
        width: 40,
        height: 40,
        borderRadius: 20,
        spacing: 10,
        runSpacing: 10,
        heading: const Text('Pick a color'),
        subheading: const Text('Select a color for your widget'),
        wheelDiameter: 200,
        wheelWidth: 20,
      ).showPickerDialog(
        context,
        backgroundColor: Theme.of(context).canvasColor,
      );
    }

    return IconButton.outlined(
      icon: Icon(Icons.circle_sharp, color: selectedColor),
      onPressed: openColorPicker,
    );
  }
}
