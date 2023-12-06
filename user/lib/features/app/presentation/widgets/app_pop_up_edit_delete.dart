import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:user/core/util/extensions/build_context.dart';
import 'package:user/core/util/responsive_padding.dart';

import '../../../../generated/locale_keys.g.dart';

class PopUpMenuDeleteEdit extends StatelessWidget {
  const PopUpMenuDeleteEdit({
    super.key,
    required this.deleteFunction,
  });

  final Function() deleteFunction;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: Icon(
          Icons.more_vert,
          color: context.colorScheme.primary,
        ),
        onSelected: (value) {
          if (value == Const.edit) {
          } else if (value == Const.delete) {
            Const.showMyDialog(
              context: context,
              title: LocaleKeys.home.tr(),
              content: LocaleKeys.home.tr(),
              onPressed: deleteFunction,
            );
          }
        },
        itemBuilder: (BuildContext context) {
          return Const.chose.map((e) {
            return PopupMenuItem<String>(
                value: e,
                child: Text(
                  e,
                  style: context.textTheme.titleSmall,
                ));
          }).toList();
        });
  }
}

class Const {
  static void showMyDialog(
          {required context,
          required String title,
          required String content,
          required dynamic Function()? onPressed}) =>
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                  title: Text(
                    title,
                    style: context.textTheme.titleMedium,
                  ),
                  elevation: 10,
                  content: Text(
                    content,
                    style: context.textTheme.titleSmall,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () =>
                            Navigator.pop(context, LocaleKeys.cancel.tr()),
                        child: Container(
                          padding: HWEdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: context.colorScheme.primary),
                              borderRadius: BorderRadius.circular(16),
                              color: context.colorScheme.secondaryContainer),
                          child: Text(
                            LocaleKeys.cancel.tr(),
                            style: context.textTheme.titleSmall!
                                .copyWith(color: context.colorScheme.primary),
                          ),
                        )),
                  ]));

  static String edit = LocaleKeys.edit.tr();
  static String delete = LocaleKeys.delete.tr();
  static List<String> chose = [edit, delete];
}
