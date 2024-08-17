import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_practice_app/old_file/model.dart';

class FullScreenImage extends StatelessWidget {
  List<ImageModel> _images = [];
  var position;

  FullScreenImage(this._images, this.position);

  @override
  Widget build(Object context) {
    return Scaffold(
      body: Container(
        child: Image.file(File(_images[position].path)),
      ),
    );
  }
}
