// ignore: file_names
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../assets/app_colors.dart';
import 'Model/ImageConfig.dart';

class ProfilePicture extends StatelessWidget {
  final String imageURL;
  final String? name;
  final double? radius;
  final double? fontSize;
  final Function()? tap;
  final File? file;

  const ProfilePicture({
    super.key,
    required this.imageURL,
    this.name,
    this.radius,
    this.tap,
    this.file,
    this.fontSize = 28,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        fit: StackFit.loose,
        children: [
          if (file != null)
            CircleAvatar(
              radius: radius?.r ?? 60.r,
              backgroundImage: FileImage(file!),
            ),
          if (file == null)
            CircularProfileAvatar(
              imageURL,
              backgroundColor: AppColors.primaryLight100,
              initialsText: Text(
                name ?? '',
                style: TextStyle(
                  fontSize: fontSize?.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
              ),
              radius: radius?.r ?? 60.r,
            ),
          if (tap != null)
            Positioned(
              left: 70,
              top: 70,
              child: GestureDetector(
                onTap: tap,
                child: CircleAvatar(
                  backgroundColor: AppColors.primary25.withAlpha((.80 * 225).toInt()),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ImageView extends StatelessWidget {
  final ImageConfig imageConfig;
  const ImageView({required this.imageConfig, super.key});

  @override
  Widget build(BuildContext context) =>
      GestureDetector(onTap: imageConfig.onTap, child: _imageBuilder());

  Widget _imageBuilder() {
    switch (imageConfig.imageType) {
      case ImageType.asset:
        return _assetImageView;
      case ImageType.network:
        return _networkImage;
      case ImageType.file:
        break;
      case ImageType.svg:
        return _svgImageView;
      case ImageType.svgNetwork:
        return _svgNetWorkView;
      default:
        return Container();
    }
    return Container();
  }

  Image get _assetImageView => Image.asset(
    imageConfig.imageURL,
    height: imageConfig.height?.h,
    width: imageConfig.width?.w,
    fit: imageConfig.boxFit,
  );

  SvgPicture get _svgImageView => SvgPicture.asset(
    imageConfig.imageURL,
    height: imageConfig.height?.h,
    width: imageConfig.width?.w,
    fit: imageConfig.boxFit!,
    color: imageConfig.color,
  );
  SvgPicture get _svgNetWorkView => SvgPicture.network(
    imageConfig.imageURL,
    height: imageConfig.height?.h,
    width: imageConfig.width?.w,
    fit: imageConfig.boxFit!,
    color: imageConfig.color,
  );

  CachedNetworkImage get _networkImage => CachedNetworkImage(
    imageUrl: imageConfig.imageURL,
    height: imageConfig.height?.h,
    width: imageConfig.width?.w,
    fit: imageConfig.boxFit!,
    color: imageConfig.color,
  );
}
