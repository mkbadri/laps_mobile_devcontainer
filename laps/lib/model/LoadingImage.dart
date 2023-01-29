import 'package:flutter/material.dart';

class LoadingImage {
  Material loadingImage;
  LoadingImage() {
    this.loadingImage = Material(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      elevation: 10,
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Image.asset(
                'assets/loading.gif',
                width: 80,
                height: 80,
              )),
    );
  }
}
