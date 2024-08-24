import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:naqla_driver/core/core.dart';

class AppDatePicker extends StatefulWidget {
  final String name;
  final EdgeInsets? margin;
  final String? title;
  final double elevation;
  final void Function(DateTime)? onDateTimeChanged;
  final String? Function(String?)? validator;
  final String? initialValue;
  final DateTime? maximumDate;
  final DateTime? minimumDate;
  final DateTime? initialDateTime;
  const AppDatePicker({
    super.key,
    required this.name,
    this.margin,
    this.maximumDate,
    this.minimumDate,
    this.initialDateTime,
    this.title,
    this.elevation = 2,
    this.validator,
    this.onDateTimeChanged,
    this.initialValue,
  });

  @override
  State<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
    super.initState();
  }

  void showDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 272.h,
        color: context.colorScheme.surface,
        child: Column(
          children: [
            const Spacer(flex: 2),
            SizedBox(
              height: 160,
              child: CupertinoDatePicker(
                maximumDate: widget.maximumDate,
                minimumDate: widget.minimumDate,
                initialDateTime: widget.initialDateTime,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (val) {
                  _controller.text = DateFormat('yyyy-MM-dd').format(val);
                  widget.onDateTimeChanged?.call(val);
                },
              ),
            ),
            const Spacer(),
            // Close the modal
            CupertinoButton(child: const Text('OK'), onPressed: () => Navigator.pop(context)),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  void showTimerPicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 272.h,
        color: context.colorScheme.surface,
        child: Column(
          children: [
            const Spacer(flex: 2),
            SizedBox(
              height: 160,
              child: CupertinoTimerPicker(
                onTimerDurationChanged: (Duration value) {},
                mode: CupertinoTimerPickerMode.hm,
              ),
            ),
            const Spacer(),
            // Close the modal
            CupertinoButton(child: const Text('OK'), onPressed: () => Navigator.of(context).pop()),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDatePicker(context),
      child: AppTextFormField(
        validator: widget.validator,
        enabled: false,
        title: widget.title,
        style: context.textTheme.bodyMedium,
        elevation: widget.elevation,
        margin: widget.margin,
        name: widget.name,
        controller: _controller,
        hintText: 'YYYY-MM-DD',
        suffixIcon: Padding(
          padding: REdgeInsets.symmetric(vertical: 14.w),
          child: AppImage.asset(
            'Assets.icons.essential.calendar.path',
            size: 15.w,
            height: 15.w,
            width: 15.w,
            color: context.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
