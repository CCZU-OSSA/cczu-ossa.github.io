import 'package:flutter/widgets.dart';

class BlurImage {
  final ImageProvider provider;
  double coloropacity = 0.3;
  double blur = 0;
  BlurImage(this.provider, {this.coloropacity = 0.3, this.blur = 0});
}
