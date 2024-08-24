import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla_driver/core/common/constants/constants.dart';
import 'package:naqla_driver/core/core.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown(
      {super.key,
      this.isExpanded = true,
      this.hideBarrierColor = false,
      required this.child,
      this.followerAnchor,
      required this.menuWidget,
      this.tooltipController});

  final OverlayPortalController? tooltipController;
  final bool hideBarrierColor;
  final Alignment? followerAnchor;
  final Widget child;
  final Widget menuWidget;
  final bool isExpanded;

  @override
  State<StatefulWidget> createState() => CustomDropDownState();
}

class CustomDropDownState extends State<CustomDropDown> {
  late final OverlayPortalController _tooltipController;

  @override
  void initState() {
    _tooltipController = widget.tooltipController ?? OverlayPortalController();
    super.initState();
  }

  final _link = LayerLink();

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      child: OverlayPortal(
        controller: _tooltipController,
        overlayChildBuilder: (BuildContext context) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              _tooltipController.toggle();
            },
            child: Container(
              color: widget.hideBarrierColor ? null : UIConstants.getShadow(context),
              child: widget.isExpanded
                  ? Column(
                      children: [
                        Expanded(
                          child: CompositedTransformFollower(
                            link: _link,
                            followerAnchor: widget.followerAnchor ?? Alignment.topLeft,
                            targetAnchor: Alignment.topLeft,
                            child: widget.menuWidget,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        CompositedTransformFollower(
                          link: _link,
                          followerAnchor: widget.followerAnchor ?? Alignment.topLeft,
                          targetAnchor: Alignment.topLeft,
                          child: widget.menuWidget,
                        ),
                      ],
                    ),
            ),
          );
        },
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: onTap,
          child: widget.child,
        ),
      ),
    );
  }

  void onTap() {
    _tooltipController.toggle();
  }
}

class AppMenuItem extends StatelessWidget {
  const AppMenuItem(
      {super.key,
      required this.isLastItem,
      this.onTap,
      required this.image,
      required this.text,
      this.showImage = true,
      this.isSelected,
      this.textColor,
      this.showCheck = false,
      this.onChanged});

  final bool isLastItem;
  final VoidCallback? onTap;
  final String image;
  final bool? isSelected;
  final bool showImage;
  final Color? textColor;
  final bool showCheck;
  final void Function(bool)? onChanged;

  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: REdgeInsets.symmetric(
              vertical: 20,
              horizontal: 16,
            ),
            height: 64.h,
            child: Row(
              children: [
                if (showImage) ...{
                  AppImage.asset(
                    image,
                    size: 24.r,
                    color: context.colorScheme.systemGray.shade400,
                  ),
                  16.horizontalSpace
                },
                AppText.bodyMedium(
                  text,
                  color: textColor ?? context.colorScheme.systemGray.shade800,
                ),
                if (showCheck) ...{
                  const Spacer(),
                  AppCheckbox(
                    onChanged: onChanged,
                    isSelected: isSelected!,
                  )
                }
              ],
            ),
          ),
          if (!isLastItem)
            const Divider(
              height: 0,
            ),
        ],
      ),
    );
  }
}

class AppPopUoMenuItem extends StatelessWidget {
  const AppPopUoMenuItem({
    super.key,
    required this.image,
    required this.text,
  });

  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AppImage.asset(
              image,
              size: 24.r,
              color: context.colorScheme.systemGray.shade400,
            ),
            19.horizontalSpace,
            AppText.bodyMedium(
              text,
              color: context.colorScheme.systemGray.shade800,
            ),
          ],
        ),
        const Divider()
      ],
    );
  }
}
