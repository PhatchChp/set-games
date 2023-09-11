import 'package:flutter/material.dart';

class GamesCard {
  GamesCard(this.color, this.shape, this.amount, this.shading, this.selected);

  Color color;
  Shape shape;
  int amount;
  Shading shading;
  bool selected;

  @override
  String toString() {
    return 'Color: ${color}Shape: ${shape}amount: ${amount}shading:${shading}selected: $selected$hashCode';
  }
}

enum Shape {
  capsule,
  triangle,
  diamonds,
}

enum Shading {
  fill,
  semiFill,
  transparant,
}

class CardColors {
  static Color red = Colors.red;
  static Color green = Colors.green;
  static Color blue = Colors.blue;
}
