// 🎯 Dart imports:
import 'dart:io';

// 📦 Package imports:
import 'package:common_state/common_state.dart';
// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/util/pick_image_sheet.dart';

import '../../features/app/presentation/state/upload_image_cubit.dart';
import '../di/di_container.dart';

enum MediaType { image, video }

class MediaFormField extends StatefulWidget {
  final String name;
  final Widget? imagePlaceHolder;
  final Widget? loadingIndicator;
  final Widget Function(File? file)? displayImageBuilder;
  final BoxDecoration? placeHolderDecoration;
  final String? title;
  final double? height;
  final double? width;
  final CropAspectRatioPreset? cropAspectRatio;
  final VoidCallback? onImagePicked;
  final MediaType mediaType;
  final String? Function(dynamic)? validator;

  const MediaFormField({
    super.key,
    required this.name,
    this.displayImageBuilder,
    this.imagePlaceHolder,
    this.loadingIndicator,
    this.height,
    this.width,
    this.placeHolderDecoration,
    this.title,
    this.cropAspectRatio,
    this.onImagePicked,
    this.mediaType = MediaType.image,
    this.validator,
  });

  @override
  State<MediaFormField> createState() => _MediaFormField2State();
}

class _MediaFormField2State extends State<MediaFormField> {
  final uploadImageCubit = getIt<UploadImageCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => uploadImageCubit,
      child: FormBuilderField(
        builder: (field) => BlocConsumer<UploadImageCubit, CommonState<String?>>(
          listener: (context, state) {
            if (state.isSuccess) field.didChange(state.data);
          },
          builder: (context, state) {
            return _MediaFormFieldPlaceHolder(
              height: widget.height,
              width: widget.width,
              title: widget.title,
              placeHolderDecoration: widget.placeHolderDecoration,
              cropAspectRatio: widget.cropAspectRatio,
              enabled: !state.isLoading,
              mediaType: widget.mediaType,
              onFilePicked: (fileThumbnail) {
                widget.onImagePicked?.call();
                uploadImageCubit.uploadImage(fileThumbnail.$1!);
              },
              isLoading: state.isLoading,
              loadingIndicator: widget.loadingIndicator,
              error: field.errorText,
              child: state.isError ? ElevatedButton(onPressed: () {}, child: const Icon(Icons.restart_alt)) : null,
            );
          },
        ),
        name: widget.name,
        validator: widget.validator,
      ),
    );
  }
}

class _MediaFormFieldPlaceHolder extends StatefulWidget {
  final BoxDecoration? placeHolderDecoration;
  final String? title;
  final double? height;
  final double? width;
  final Widget? child;
  final bool enabled;
  final CropAspectRatioPreset? cropAspectRatio;
  final ValueChanged<(File? previewFile, File? thumbnail)>? onFilePicked;
  final bool isLoading;
  final Widget? loadingIndicator;
  final String? error;
  final MediaType mediaType;

  const _MediaFormFieldPlaceHolder({
    this.height,
    this.placeHolderDecoration,
    this.title,
    this.width,
    this.child,
    this.cropAspectRatio,
    this.enabled = true,
    this.onFilePicked,
    this.isLoading = false,
    this.loadingIndicator,
    this.error,
    this.mediaType = MediaType.image,
  });

  @override
  State<_MediaFormFieldPlaceHolder> createState() => __MediaFormFieldPlaceHolderState();
}

class __MediaFormFieldPlaceHolderState extends State<_MediaFormFieldPlaceHolder> with AutomaticKeepAliveClientMixin {
  File? previewFile;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        GestureDetector(
          onTap: !widget.enabled
              ? null
              : () async {
                  await showMaterialModalBottomSheet(
                    context: context,
                    builder: (context) => PickMediaFileSheet(
                      mediaType: widget.mediaType,
                      onPickFile: (file, thumbnail) {
                        setState(() {
                          if (widget.mediaType == MediaType.video) {
                            previewFile = thumbnail;
                          } else {
                            previewFile = file;
                          }
                        });
                        widget.onFilePicked?.call((file, thumbnail));
                      },
                      cropAspectRatio: widget.cropAspectRatio,
                    ),
                  );
                },
          child: Container(
            decoration: widget.placeHolderDecoration?.copyWith(
              border: widget.error == null
                  ? null
                  : Border.all(
                      color: context.colorScheme.error,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      width: 2,
                    ),
            ),
            width: widget.width,
            height: widget.height,
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                Center(
                  child: previewFile != null
                      ? Image.file(
                          previewFile!,
                          fit: BoxFit.cover,
                          width: widget.width,
                          height: widget.height,
                        )
                      : widget.child ??
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconlyBroken.image,
                                size: 24.r,
                              ),
                              if (widget.title != null) AppText.titleSmall(widget.title!)
                            ],
                          ),
                ),
                if (widget.isLoading)
                  Container(
                    color: Colors.black.withOpacity(.2),
                    child: Center(
                      child: widget.loadingIndicator ??
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(color: context.colorScheme.primary),
                              10.verticalSpace,
                              AppText.labelSmall('Uploading...', color: Colors.white),
                            ],
                          ),
                    ),
                  )
              ],
            ),
          ),
        ),
        if (widget.error != null) ...{10.verticalSpace, AppText.labelSmall(widget.error!, color: Colors.red)},
      ],
    );
  }
}
