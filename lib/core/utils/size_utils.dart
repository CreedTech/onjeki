// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const num FIGMA_DESIGN_WIDTH = 428;
const num FIGMA_DESIGN_HEIGHT = 926;
const num FIGMA_DESIGN_STATUS_BAR = 0;

extension ResponsiveExtension on num {
  double get _width => SizeUtils.width;
  double get h => ((this * _width) / FIGMA_DESIGN_WIDTH);
  double get fSize => ((this * _width) / FIGMA_DESIGN_WIDTH);
}

extension FormatExtension on double {
  double toDoubleValue({int fractionDigits = 2}) {
    return double.parse(toStringAsFixed(fractionDigits));
  }

  double isNonZero({double defaultValue = 0.0}) {
    return this > 0.0 ? this : defaultValue.toDouble();
  }
}

enum DeviceType { mobile, tablet, desktop }

typedef ResponsiveBuild = Widget Function(
  BuildContext context,
  Orientation orientation,
  DeviceType deviceType,
);

class Sizer extends StatelessWidget {
  final ResponsiveBuild builder;

  const Sizer({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          SizeUtils.setScreenSize(constraints, orientation);
          return builder(context, orientation, SizeUtils.deviceType);
        });
      },
    );
  }
}

class SizeUtils {
  /// Device's BoxConstraints
  static late BoxConstraints boxConstraints;

  /// Device's orientation
  static late Orientation orientation;

  /// Type of device
  /// [DeviceType.mobile] for phones
  /// [DeviceType.tablet] for tablets
  /// [DeviceType.desktop] for desktops
  static late DeviceType deviceType;

  /// Device's height
  static late double height;

  /// Device's width
  static late double width;

  static void setScreenSize(
    BoxConstraints constraints,
    Orientation currentOrientation,
  ) {
    boxConstraints = constraints;
    orientation = currentOrientation;

    if (orientation == Orientation.portrait) {
      width = boxConstraints.maxWidth
          .isNonZero(defaultValue: FIGMA_DESIGN_WIDTH.toDouble());
      height = boxConstraints.maxHeight.isNonZero();
    } else {
      height = boxConstraints.maxWidth
          .isNonZero(defaultValue: FIGMA_DESIGN_WIDTH.toDouble());
      width = boxConstraints.maxHeight.isNonZero();
    }
    deviceType = DeviceType.mobile;
  }
}
