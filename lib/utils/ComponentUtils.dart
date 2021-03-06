import 'package:flutter/material.dart';

class ComponentUtils {

  static Text buildStyledText(String data, double scale) {
    return new Text(
      data,
      textScaleFactor: scale,
      textAlign: TextAlign.center,
      style: new TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontStyle: FontStyle.italic
      ),
    );
  }

  static IconButton buildIconButton(IconData iconData, double iconSize, Function doOnPressed) {
    return new IconButton(
        icon: new Icon(
            iconData
        ),
        iconSize: iconSize,
        onPressed: doOnPressed);
  }
}
