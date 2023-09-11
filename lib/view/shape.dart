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
            ? Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  ClipPath(
                    clipper: TriangleShape(),
                    child: Container(
                      width: 100,
                      height: 50,
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
                      width: 87,
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            : ClipPath(
                clipper: TriangleShape(),
                child: Container(
                  color: shading == Shading.semiFill
                      ? color.withOpacity(0.5)
                      : color,
                  width: 100,
                  height: 50,
                ),
              );
      case Shape.diamonds:
        return shading == Shading.transparant
            ? Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  ClipPath(
                    clipper: DiamondShape(),
                    child: Container(
                      width: 100,
                      height: 50,
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
                      width: 80,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            : ClipPath(
                clipper: DiamondShape(),
                child: Container(
                  color: shading == Shading.semiFill
                      ? color.withOpacity(0.5)
                      : color,
                  width: 100,
                  height: 50,
                ),
              );
      case Shape.capsule:
        return shading == Shading.transparant
            ? Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        color: shading == Shading.semiFill
                            ? color.withOpacity(0.5)
                            : color,
                        width: 100,
                        height: 50,
                      )),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        color: Colors.white,
                        width: 90,
                        height: 40,
                      )),
                ],
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  color: shading == Shading.semiFill
                      ? color.withOpacity(0.5)
                      : color,
                  width: 100,
                  height: 50,
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

// // สามเหลี่ยม
// triangle(Color color) {
//   return ClipPath(
//     clipper: TriangleShape(),
//     child: Container(
//       color: color,
//       width: double.infinity,
//       height: 46,
//     ),
//   );
// }

// // ข้าวหลามตัด
// diamond() {
//   return ClipPath(
//     clipper: DiamondShape(),
//     child: Container(
//       width: 100,
//       height: 100,
//       decoration: const BoxDecoration(
//         color: Colors.red,
//       ),
//     ),
//   );
// }

// // แคปซูล
// capsual() {
//   return ClipRRect(
//     borderRadius: BorderRadius.circular(100),
//     child: Container(
//       color: Colors.blue,
//       width: 100,
//       height: 50,
//     ),
//   );
// }

// // ข้าวหลามตัด
// diamondTransparent() {
//   return Stack(
//     alignment: AlignmentDirectional.center,
//     children: [
//       ClipPath(
//         clipper: DiamondShape(),
//         child: Container(
//           width: 100,
//           height: 100,
//           decoration: const BoxDecoration(
//             color: Colors.red,
//           ),
//         ),
//       ),
//       ClipPath(
//         clipper: DiamondShape(),
//         child: Container(
//           width: 90,
//           height: 90,
//           decoration: const BoxDecoration(
//             color: Colors.white,
//           ),
//         ),
//       ),
//     ],
//   );
// }

// // แคปซูล

// capsualTransparent() {
//   return ClipRRect(
//     child: Container(
//       width: 100,
//       height: 50,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(100),
//         color: Colors.blue,
//       ),
//     ),
//   );
// }

 // triangle(),
        // capsual(),
        // diamondFill(),
        // diamondTransparent(),
        // capsualTransparent(),