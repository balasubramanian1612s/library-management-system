import 'dart:html';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class MyImage extends StatelessWidget {
  String url;
  int height;
  int width;
  MyImage(this.url, this.height, this.width);
  @override
  Widget build(BuildContext context) {
    // https://github.com/flutter/flutter/issues/41563
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      url,
      (int _) => ImageElement()
        ..src = url
        ..height = height
        ..width = width,
    );
    return SizedBox(
      height: height.toDouble(),
      width: width.toDouble(),
      child: HtmlElementView(
        viewType: url,
      ),
    );
  }
}
