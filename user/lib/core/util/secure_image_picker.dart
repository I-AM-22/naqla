import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:naqla/core/core.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class SecureFilePicker {
  static const fileSizeLimit = 4000000;

  static Future<File?> pickImage(ImageSource source, {CropAspectRatioPreset? cropAspectRatio, required BuildContext context}) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile == null) return null;

    final file = File(pickedFile.path);

    final File compressedFile = await _compressAndGetFile(
      file,
    );

    if (!validateFile(compressedFile)) return null;

    // if (!context.mounted) return null;
    // needs cropping
    if (cropAspectRatio != null) {
      final croppedFile = await _cropImage(compressedFile, aspectRatioPreset: cropAspectRatio, context: context);
      return croppedFile;
    }

    return compressedFile;
  }

  static Future<List<File?>?> pickMultiImage({CropAspectRatioPreset? cropAspectRatio, required BuildContext context}) async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> pickedFile = await picker.pickMultiImage();

    final List<File> files = List<File>.generate(pickedFile.length, (index) => File(pickedFile[index].path));

    if (files.isEmpty) return null;

    final List<File> compressedFile = [];
    for (var i = 0; i < files.length; i++) {
      compressedFile.add(await _compressAndGetFile(File(files[i].path)));
      if (!validateFile(compressedFile[i])) return null;
    }

    if (cropAspectRatio != null) {
      final List<File?> croppedFile = [];
      for (var i = 0; i < compressedFile.length; i++) {
        croppedFile.add(await _cropImage(compressedFile[i], context: context));
      }
      return croppedFile;
    }

    return compressedFile;
  }

  static bool validateFile(File file) {
    // Check file size
    if (file.lengthSync() > fileSizeLimit) return false;

    // Check actual file type
    final mimeType = lookupMimeType(file.path);
    if (mimeType == null || !mimeType.startsWith('image/')) return false;

    return true;
  }

  static Future<File> _compressAndGetFile(File sourceFile, {int? targetSize}) async {
    final dir = await getTemporaryDirectory();
    final targetPath = '${dir.absolute.path}/${const Uuid().v4()}.jpg';

    for (int quality = 80; quality >= 40; quality -= 5) {
      final data = await FlutterImageCompress.compressAndGetFile(
        sourceFile.absolute.path,
        targetPath,
        quality: quality,
      );

      final file = File(data?.path ?? '');

      if (targetSize == null) return file;

      if (file.lengthSync() < targetSize) return file;
    }
    throw Exception("Image is too large, cannot compress below target size");
  }

  static Future<File?> _cropImage(final File file,
      {CropAspectRatioPreset aspectRatioPreset = CropAspectRatioPreset.ratio16x9,
      CropAspectRatio? aspectRatio,
      required BuildContext context}) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatio: aspectRatio,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          aspectRatioPresets: [aspectRatioPreset],
          toolbarColor: context.colorScheme.primary,
          toolbarWidgetColor: context.colorScheme.primaryContainer,
          initAspectRatio: aspectRatioPreset,
          lockAspectRatio: true, //TODO MAKE IT CUSTOMIZABLE
        ),
        IOSUiSettings(title: 'Cropper'),
      ],
    );
    if (croppedFile == null) {
      return null;
    }

    return File(croppedFile.path);
  }
}
