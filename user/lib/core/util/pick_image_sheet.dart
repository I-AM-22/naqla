import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/util/secure_image_picker.dart';

import 'media_form_field.dart';

class PickMediaFileSheet extends StatefulWidget {
  final MediaType mediaType;
  const PickMediaFileSheet({
    super.key,
    this.mediaType = MediaType.image,
    this.onPickFile,
    this.cropAspectRatio,
  });

  final Function(File file, File? thumpNail)? onPickFile;
  final CropAspectRatioPreset? cropAspectRatio;

  @override
  State<PickMediaFileSheet> createState() => _PickMediaFileSheetState();
}

class _PickMediaFileSheetState extends State<PickMediaFileSheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.fullWidth,
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () async {
              final File? file;
              File? thumbnail;

              file = await SecureFilePicker.pickImage(
                context: context,
                ImageSource.camera,
                cropAspectRatio: widget.cropAspectRatio,
              );

              if (mounted && file != null) {
                Navigator.pop(context, file);
                widget.onPickFile?.call(file, thumbnail);
              }
            },
            child: const ImageSheetButton(isCamera: true),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () async {
              final File? file;
              File? thumbnail;

              file = await SecureFilePicker.pickImage(
                context: context,
                ImageSource.gallery,
                cropAspectRatio: widget.cropAspectRatio,
              );

              if (mounted && file != null) {
                Navigator.pop(context, file);
                widget.onPickFile?.call(file, thumbnail);
              }
            },
            child: const ImageSheetButton(),
          )
        ],
      ),
    );
  }
}

class ImageSheetButton extends StatelessWidget {
  final bool isCamera;
  final double? width;
  final double? height;
  const ImageSheetButton({super.key, this.isCamera = false, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: width ?? context.fullWidth * .40,
        height: height ?? context.fullWidth * .40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: context.colorScheme.outline, width: 3),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            RSizedBox(
              height: 60,
              child: Icon(isCamera ? IconlyBroken.camera : IconlyBroken.image),
            ),
            AppText.titleSmall(
              isCamera ? 'التقط صورة' : 'اختر من المعرض',
              textAlign: TextAlign.center,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
