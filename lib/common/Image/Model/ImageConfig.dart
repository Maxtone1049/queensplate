import 'dart:io';

import 'package:flutter/material.dart';

enum ImageType { asset, network, file, svg ,svgNetwork}

class ImageConfig {
  final String imageURL;
  final ImageType? imageType;
  final double? height;
  final double? width;
  BoxFit? boxFit;
  final Color? color;
  final Function()? onTap;
  final File? file;

  ImageConfig({
    required this.imageURL,
    this.imageType = ImageType.svg,
    this.height,
    this.width,
    this.boxFit = BoxFit.contain,
    this.color,
    this.onTap,
    this.file,
  });
}
