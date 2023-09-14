import 'package:flutter/material.dart';
import 'package:setgame/model/model.dart';
import 'package:setgame/view/shape.dart';

class CardsWidget extends StatelessWidget {
  const CardsWidget(
      this.color, this.shape, this.amount, this.shading, this.selected,
      {super.key});

  final Color color;
  final Shape shape;
  final int amount;
  final Shading shading;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: selected ? Colors.yellowAccent.shade100 : Colors.grey.shade50,
        border: selected
            ? Border.all(color: Colors.pink, width: 4)
            : Border.all(color: Colors.black, width: 4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < amount; i++)
            Padding(
              padding: const EdgeInsets.all(4),
              child: ShapeWidget(color, shape, shading),
            ),
        ],
      ),
    );
  }
}
