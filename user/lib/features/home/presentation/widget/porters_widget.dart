import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/generated/l10n.dart';
import 'package:numberpicker/numberpicker.dart';

class PortersWidget extends StatefulWidget {
  const PortersWidget({super.key, required this.onChange});
  final Function(int, bool) onChange;

  @override
  State<PortersWidget> createState() => _PortersWidgetState();
}

class _PortersWidgetState extends State<PortersWidget> {
  final ValueNotifier<bool> porters = ValueNotifier(false);
  int _currentValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ValueListenableBuilder(
              builder: (context, value, _) => AppCheckbox(
                isSelected: value,
                onChanged: (value) {
                  porters.value = value;
                  widget.onChange(_currentValue, porters.value);
                  setState(() {});
                },
              ),
              valueListenable: porters,
            ),
            8.horizontalSpace,
            AppText.bodySmMedium(
              S.of(context).porters,
              color: Colors.black,
            )
          ],
        ),
        11.verticalSpace,
        AppText.bodySmMedium(S
            .of(context)
            .the_remuneration_will_depend_on_the_number_of_porters_required),
        10.verticalSpace,
        AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: porters.value ? 1 : 0,
          child: AnimatedSize(
            duration: const Duration(milliseconds: 300),
            reverseDuration: const Duration(milliseconds: 1000),
            child: porters.value
                ? Row(
                    children: [
                      Flexible(
                          child: AppText.titleSmall(
                              S.of(context).total_number_of_floors)),
                      10.horizontalSpace,
                      NumberPicker(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: context.colorScheme.outline),
                            borderRadius: BorderRadius.circular(8)),
                        value: _currentValue,
                        textStyle: context.textTheme.bodySmMedium,
                        minValue: 0,
                        maxValue: 100,
                        onChanged: (value) => setState(() {
                          _currentValue = value;
                          widget.onChange(value, porters.value);
                        }),
                      ),
                    ],
                  )
                : const SizedBox(),
          ),
        )
      ],
    );
  }
}
