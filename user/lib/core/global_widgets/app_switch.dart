import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/util/extensions.dart';

class AppSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const AppSwitch({super.key, required this.value, required this.onChanged});

  @override
  createState() => _AppSwitchState();
}

class _AppSwitchState extends State<AppSwitch>
    with SingleTickerProviderStateMixin {
  Animation? _circleAnimation;
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 70));
    _circleAnimation = AlignmentTween(
            begin: !widget.value ? Alignment.centerLeft : Alignment.centerRight,
            end: !widget.value ? Alignment.centerRight : Alignment.centerLeft)
        .animate(CurvedAnimation(
            parent: _animationController!, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _circleAnimation!,
      builder: (context, child) {
        return GestureDetector(
          onPanUpdate: (details) {
            // Swiping in right direction.
            if (details.delta.dx > 0) {
              if (!widget.value) {
                toggle();
              }
            }

            // Swiping in left direction.
            if (details.delta.dx < 0) {
              if (widget.value) {
                toggle();
              }
            }
          },
          onTap: toggle,
          child: Container(
            width: 45.0.w,
            height: 24.0.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: !widget.value
                  ? const Color(0xffF2F4F7)
                  : const Color(0xffFB5607),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 2.0, bottom: 2.0, right: 2.0, left: 2.0),
              child: Align(
                alignment: _circleAnimation!.value,
                child: Container(
                  width: 20.0.r,
                  height: 20.0.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colorScheme.surface,
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0x0F101828),
                          offset: Offset(0, 1),
                          blurRadius: 2),
                      BoxShadow(
                          color: Color(0x1A101828),
                          offset: Offset(0, 1),
                          blurRadius: 3),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void toggle() {
    if (_animationController!.isCompleted) {
      _animationController!.reverse();
    } else {
      _animationController!.forward();
    }
    widget.value == false
        ? widget.onChanged?.call(true)
        : widget.onChanged?.call(false);
  }
}
