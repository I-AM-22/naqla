import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:naqla_driver/core/core.dart';

import '../../../../core/util/core_helper_functions.dart';
import '../../../../generated/l10n.dart';

class ColorCar extends StatefulWidget {
  const ColorCar({super.key, this.color});
  final String? color;

  @override
  State<ColorCar> createState() => _ColorCarState();
}

class _ColorCarState extends State<ColorCar> {
  Color pickerColor = const Color(0xff443a49);
  Color? currentColor;
  TextEditingController controller = TextEditingController();

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  void initState() {
    if (widget.color != null) {
      controller.text = widget.color!;
      currentColor = CoreHelperFunctions.hexToColor(widget.color!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (context.fullWidth / 2) - 16.w,
      child: AppTextFormField(
        key: const ObjectKey('colors'),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: currentColor ?? context.colorScheme.primary)),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: currentColor ?? context.colorScheme.primary), borderRadius: BorderRadius.circular(8)),
        title: S.of(context).color,
        style: TextStyle(color: currentColor),
        name: 'color',
        controller: controller,
        readOnly: true,
        validator: FormBuilderValidators.required(),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: AppText(S.of(context).pick_a_color),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: pickerColor,
                  onColorChanged: changeColor,
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: AppText(S.of(context).Save),
                  onPressed: () {
                    setState(() {
                      currentColor = pickerColor;
                      controller.text = currentColor?.value.toRadixString(16) ?? '';
                    });

                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
