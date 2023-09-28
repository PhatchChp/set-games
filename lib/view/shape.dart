import 'package:flutter/material.dart';
import 'package:setgame/model/model.dart';

class ShapeWidget extends StatelessWidget {
  const ShapeWidget(this.color, this.shape, this.shading, {super.key});

  final Color color;
  final Shape shape;
  final Shading shading;

  @override
  Widget build(BuildContext context) {
    switch (shape) {
      case Shape.triangle:
        return shading == Shading.transparant
            ? SizedBox(
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    ClipPath(
                      clipper: TriangleShape(),
                      child: Container(
                        width: 70,
                        height: 30,
                        decoration: BoxDecoration(
                          color: shading == Shading.semiFill
                              ? color.withOpacity(0.5)
                              : color,
                        ),
                      ),
                    ),
                    ClipPath(
                      clipper: TriangleShape(),
                      child: Container(
                        width: 50,
                        height: 22,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : SizedBox(
                child: ClipPath(
                  clipper: TriangleShape(),
                  child: Container(
                    color: shading == Shading.semiFill
                        ? color.withOpacity(0.5)
                        : color,
                    width: 70,
                    height: 30,
                  ),
                ),
              );
      case Shape.diamonds:
        return shading == Shading.transparant
            ? SizedBox(
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    ClipPath(
                      clipper: DiamondShape(),
                      child: Container(
                        width: 70,
                        height: 30,
                        decoration: BoxDecoration(
                          color: shading == Shading.semiFill
                              ? color.withOpacity(0.5)
                              : color,
                        ),
                      ),
                    ),
                    ClipPath(
                      clipper: DiamondShape(),
                      child: Container(
                        width: 50,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : SizedBox(
                child: ClipPath(
                  clipper: DiamondShape(),
                  child: Container(
                    color: shading == Shading.semiFill
                        ? color.withOpacity(0.5)
                        : color,
                    width: 70,
                    height: 30,
                  ),
                ),
              );
      case Shape.capsule:
        return shading == Shading.transparant
            ? SizedBox(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          color: shading == Shading.semiFill
                              ? color.withOpacity(0.5)
                              : color,
                          width: 70,
                          height: 30,
                        )),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          color: Colors.white,
                          width: 60,
                          height: 20,
                        )),
                  ],
                ),
              )
            : SizedBox(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    color: shading == Shading.semiFill
                        ? color.withOpacity(0.5)
                        : color,
                    width: 70,
                    height: 30,
                  ),
                ),
              );
      default:
        return Container();
    }
  }
}

class TriangleShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// ข้าวหลามตัด
class DiamondShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.5);
    // บน
    path.lineTo(size.width * 0.5, 0);
    path.lineTo(size.width, size.height * 0.5);
    // ล่าง
    path.lineTo(size.width, size.height * 0.5);
    path.lineTo(size.width * 0.5, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
