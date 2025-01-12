import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

extension ImageTypeExtension on String {
  ImageType get imageType {
    if (startsWith('http') || startsWith('https')) {
      return ImageType.network;
    } else if (endsWith('.svg')) {
      return ImageType.svg;
    } else if (startsWith('file://')) {
      return ImageType.file;
    } else {
      return ImageType.png;
    }
  }
}

enum ImageType { svg, png, network, file, unknown }

class CustomImageView extends StatelessWidget {
  const CustomImageView(
      {super.key,
      this.imagePath,
      this.width,
      this.height,
      this.color,
      this.fit,
      this.placeholder = 'assets/images/splashscreen-2.png',
      this.alignment,
      this.onTap,
      this.margin,
      this.radius,
      this.border});

  final String? imagePath;

  final double? width;

  final double? height;

  final Color? color;

  final BoxFit? fit;

  final String placeholder;

  final Alignment? alignment;

  final VoidCallback? onTap;

  final EdgeInsetsGeometry? margin;

  final BorderRadius? radius;

  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment!,
            child: _buildWidget(),
          )
        : _buildWidget();
  }

  Widget _buildWidget() {
    return Padding(
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: _buildCircleImage(),
      ),
    );
  }

  _buildCircleImage() {
    if (radius != null) {
      return ClipRRect(
        borderRadius: radius ?? BorderRadius.zero,
        child: _buildImageWithBorder(),
      );
    } else {
      return _buildImageWithBorder();
    }
  }

  _buildImageWithBorder() {
    if (border != null) {
      return Container(
        decoration: BoxDecoration(
          border: border,
          borderRadius: radius,
        ),
        child: _buildImageView(),
      );
    } else {
      return _buildImageView();
    }
  }

  Widget _buildImageView() {
    if (imagePath != null) {
      switch (imagePath!.imageType) {
        case ImageType.svg:
          return SizedBox(
            height: height,
            width: width,
            child: SvgPicture.asset(
              imagePath!,
              width: width,
              height: height,
              fit: fit ?? BoxFit.contain,
              colorFilter: color != null
                  ? ColorFilter.mode(
                      color ?? Colors.transparent, BlendMode.srcIn)
                  : null,
            ),
          );
        case ImageType.network:
          return CachedNetworkImage(
            width: width,
            height: height,
            color: color,
            fit: fit,
            imageUrl: imagePath!,
            placeholder: (context, url) => SizedBox(
              height: 30,
              width: 30,
              child: Center(
                child: LinearProgressIndicator(
                  color: Colors.grey.shade200,
                  backgroundColor: Colors.grey.shade100,
                ),
              ),
            ),
            errorWidget: (context, url, error) => Image.asset(
              placeholder,
              width: width,
              height: height,
              fit: fit ?? BoxFit.cover,
            ),
          );
        case ImageType.file:
          return Image.file(
            File(imagePath!),
            width: width,
            height: height,
            color: color,
            fit: fit ?? BoxFit.cover,
          );
        case ImageType.png:
          return Image.asset(
            imagePath!,
            width: width,
            height: height,
            color: color,
            fit: fit,
          );
        default:
          return Image.asset(
            imagePath!,
            width: width,
            height: height,
            color: color,
            fit: fit ?? BoxFit.cover,
          );
      }
    }
    return const SizedBox();
  }
}
