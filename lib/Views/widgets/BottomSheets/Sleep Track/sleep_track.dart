import 'package:flutter/material.dart';
import 'package:profit1/utils/colors.dart';
import 'dart:math' as math;
import 'package:get/get.dart';

import '../../../pages/Features/Sleep Track/controller/sleep_track_controller.dart';
import '../../General/customBotton.dart';
import 'sleep_track_continer.dart';

void showSleepTrackBottomSheet(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
    builder: (BuildContext context) {
      return SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.58,
          ),
          child: SleepTrackContent(),
        ),
      );
    },
  );
}

class SleepTrackContent extends StatelessWidget {
  final SleepTrackController controller = Get.put(SleepTrackController());

  SleepTrackContent() {
    // Initialize start and end angles to represent 12 and 6
    controller.startAngle.value = _timeToAngle(0, 0); // 12 AM (top)
    controller.endAngle.value = _timeToAngle(6, 0); // 6 AM (bottom)
  }

  @override
  Widget build(BuildContext context) {
    final size = 200.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Sleep Track",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        Center(
          child: GestureDetector(
            onPanStart: (details) {
              RenderBox box = context.findRenderObject() as RenderBox;
              Offset localPosition = box.globalToLocal(details.globalPosition);
              final distanceToStart = (localPosition -
                      _calculateHandlePosition(controller.startAngle.value, size / 2))
                  .distance;
              final distanceToEnd =
                  (localPosition - _calculateHandlePosition(controller.endAngle.value, size / 2))
                      .distance;

              if (distanceToStart < distanceToEnd) {
                controller.isDraggingStart.value = true;
                controller.isDraggingEnd.value = false;
              } else {
                controller.isDraggingStart.value = false;
                controller.isDraggingEnd.value = true;
              }
            },
            onPanUpdate: (details) {
              RenderBox box = context.findRenderObject() as RenderBox;
              Offset localPosition = box.globalToLocal(details.globalPosition);
              if (controller.isDraggingStart.value) {
                controller.updateStartAngle(_calculateAngle(localPosition, Size(size, size)));
              } else if (controller.isDraggingEnd.value) {
                controller.updateEndAngle(_calculateAngle(localPosition, Size(size, size)));
              }
            },
            onPanEnd: (details) {
              controller.isDraggingStart.value = false;
              controller.isDraggingEnd.value = false;
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                    top: 10,
                    left: 10,
                    child: Image.asset(
                      'assets/images/Group124.png',
                    )),
                Obx(() => CustomPaint(
                  size: Size(size, size),
                  painter: CircularSliderPainter(controller.startAngle.value, controller.endAngle.value),
                )),
                Obx(() => _buildHandle(controller.startAngle.value, size / 2, true, context)),
                Obx(() => _buildHandle(controller.endAngle.value, size / 2, false, context)),
              ],
            ),
          ),
        ),
        Center(
          child: Obx(() => _calculateSleepDuration(controller.startAngle.value, controller.endAngle.value)),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => CustomSleepTimeContainer(
                label: 'Fall asleep time',
                time: controller.formatTime(controller.startAngle.value),
                svgIconPath: 'assets/svgs/moon.svg',
              )),
              const SizedBox(width: 16),
              Obx(() => CustomSleepTimeContainer(
                label: 'Woke up',
                time: controller.formatTime(controller.endAngle.value),
                svgIconPath: 'assets/svgs/sun.svg',
              )),
              const SizedBox(width: 16),
            ],
          ),
        ),
        const SizedBox(height: 16),
        CustomButton(
          text: 'Add Sleep Time',
          onPressed: () async {
            await controller.saveSleepTrack();
            await controller.fetchLatestSleepData();
            Navigator.pop(context);
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  double _calculateAngle(Offset position, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final vector = position - center;
    double angle = vector.direction;
    if (angle < -math.pi / 2) {
      angle += 2 * math.pi;
    }
    return angle;
  }

  Offset _calculateHandlePosition(double angle, double radius) {
    return Offset(
      radius * math.cos(angle) + radius,
      radius * math.sin(angle) + radius,
    );
  }

  double _timeToAngle(int hour, int minute) {
    final totalMinutes = hour * 60 + minute;
    return ((totalMinutes / 720) * 2 * math.pi) - (math.pi / 2); // Convert to radians and adjust
  }

  Widget _calculateSleepDuration(double startAngle, double endAngle) {
    final totalMinutesStart = ((startAngle + (math.pi / 2)) / (2 * math.pi) * 720).round();
    final totalMinutesEnd = ((endAngle + (math.pi / 2)) / (2 * math.pi) * 720).round();
    int sleepMinutes = totalMinutesEnd - totalMinutesStart;

    if (sleepMinutes < 0) {
      sleepMinutes += 720;
    }

    final hours = sleepMinutes ~/ 60;
    final minutes = sleepMinutes % 60;

    return Column(
      children: [
        SizedBox(height: 16),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${hours.toString().padLeft(2, '0')}',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  color: blue500,
                  fontFamily: 'BoldCairo',
                ),
              ),
              const TextSpan(
                text: ' hrs ',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  color: colorBlue,
                ),
              ),
              TextSpan(
                text: '${minutes.toString().padLeft(2, '0')}',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  color: blue500,
                  fontFamily: 'BoldCairo',
                ),
              ),
              const TextSpan(
                text: ' mins',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  color: colorBlue,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHandle(double angle, double radius, bool isStartHandle, BuildContext context) {
    return Transform.translate(
      offset: Offset(
        radius * math.cos(angle),
        radius * math.sin(angle),
      ),
      child: GestureDetector(
        onPanUpdate: (details) {
          RenderBox box = context.findRenderObject() as RenderBox;
          Offset localPosition = box.globalToLocal(details.globalPosition);
          if (isStartHandle) {
            final controller = Get.find<SleepTrackController>();
            controller.updateStartAngle(_calculateAngle(localPosition, Size(radius * 2, radius * 2)));
          } else {
            final controller = Get.find<SleepTrackController>();
            controller.updateEndAngle(_calculateAngle(localPosition, Size(radius * 2, radius * 2)));
          }
        },
        child: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: blue600, width: 6),
          ),
        ),
      ),
    );
  }
}

class CircularSliderPainter extends CustomPainter {
  final double startAngle;
  final double endAngle;

  CircularSliderPainter(this.startAngle, this.endAngle);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = colorBlue
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    if (endAngle >= startAngle) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        endAngle - startAngle,
        false,
        paint,
      );
    } else {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        2 * math.pi - startAngle + endAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


// import 'package:flutter/material.dart';
// import 'package:profit1/utils/colors.dart';
// import 'dart:math' as math;
// import 'package:get/get.dart';

// import '../../../pages/Features/Sleep Track/controller/sleep_track_controller.dart';
// import '../../General/customBotton.dart';
// import 'sleep_track_continer.dart';

// void showSleepTrackBottomSheet(BuildContext context) {
//   showModalBottomSheet(
//     isScrollControlled: true,
//     context: context,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(12),
//         topRight: Radius.circular(12),
//       ),
//     ),
//     builder: (BuildContext context) {
//       return SafeArea(
//         child: Container(
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20),
//               topRight: Radius.circular(20),
//             ),
//           ),
//           constraints: BoxConstraints(
//             maxHeight: MediaQuery.of(context).size.height * 0.58,
//           ),
//           child: SleepTrackContent(),
//         ),
//       );
//     },
//   );
// }

// class SleepTrackContent extends StatelessWidget {
//   final SleepTrackController controller = Get.put(SleepTrackController());

//   SleepTrackContent() {
//     // Initialize start and end angles to represent 12 and 6
//     controller.startAngle.value = _timeToAngle(0, 0); // 12 AM (top)
//     controller.endAngle.value = _timeToAngle(6, 0); // 6 AM (bottom)
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = 200.0;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 16, top: 16),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 "Sleep Track",
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.close),
//                 onPressed: () => Navigator.pop(context),
//               ),
//             ],
//           ),
//         ),
//         Center(
//           child: GestureDetector(
//             onPanStart: (details) {
//               RenderBox box = context.findRenderObject() as RenderBox;
//               Offset localPosition = box.globalToLocal(details.globalPosition);
//               final distanceToStart = (localPosition -
//                       _calculateHandlePosition(controller.startAngle.value, size / 2))
//                   .distance;
//               final distanceToEnd =
//                   (localPosition - _calculateHandlePosition(controller.endAngle.value, size / 2))
//                       .distance;

//               if (distanceToStart < distanceToEnd) {
//                 controller.isDraggingStart.value = true;
//                 controller.isDraggingEnd.value = false;
//               } else {
//                 controller.isDraggingStart.value = false;
//                 controller.isDraggingEnd.value = true;
//               }
//             },
//             onPanUpdate: (details) {
//               RenderBox box = context.findRenderObject() as RenderBox;
//               Offset localPosition = box.globalToLocal(details.globalPosition);
//               if (controller.isDraggingStart.value) {
//                 controller.updateStartAngle(_calculateAngle(localPosition, Size(size, size)));
//               } else if (controller.isDraggingEnd.value) {
//                 controller.updateEndAngle(_calculateAngle(localPosition, Size(size, size)));
//               }
//             },
//             onPanEnd: (details) {
//               controller.isDraggingStart.value = false;
//               controller.isDraggingEnd.value = false;
//             },
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 Positioned(
//                     top: 10,
//                     left: 10,
//                     child: Image.asset(
//                       'assets/images/Group124.png',
//                     )),
//                 Obx(() => CustomPaint(
//                   size: Size(size, size),
//                   painter: CircularSliderPainter(controller.startAngle.value, controller.endAngle.value),
//                 )),
//                 Obx(() => _buildHandle(controller.startAngle.value, size / 2, true, context)),
//                 Obx(() => _buildHandle(controller.endAngle.value, size / 2, false, context)),
//               ],
//             ),
//           ),
//         ),
//         Center(
//           child: Obx(() => _calculateSleepDuration(controller.startAngle.value, controller.endAngle.value)),
//         ),
//         const SizedBox(height: 16),
//         Padding(
//           padding: const EdgeInsets.only(left: 16),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Obx(() => CustomSleepTimeContainer(
//                 label: 'Fall asleep time',
//                 time: controller.formatTime(controller.startAngle.value),
//                 svgIconPath: 'assets/svgs/moon.svg',
//               )),
//               const SizedBox(width: 16),
//               Obx(() => CustomSleepTimeContainer(
//                 label: 'Woke up',
//                 time: controller.formatTime(controller.endAngle.value),
//                 svgIconPath: 'assets/svgs/sun.svg',
//               )),
//               const SizedBox(width: 16),
//             ],
//           ),
//         ),
//         const SizedBox(height: 16),
//         CustomButton(
//           text: 'Add Sleep Time',
        
//           onPressed: () async {
//             await controller.saveSleepTrack();
          
//             await controller.fetchLatestSleepData();
//             Navigator.pop(context);

//           },
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }

//   double _calculateAngle(Offset position, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final vector = position - center;
//     double angle = vector.direction;
//     if (angle < -math.pi / 2) {
//       angle += 2 * math.pi;
//     }
//     return angle;
//   }

//   Offset _calculateHandlePosition(double angle, double radius) {
//     return Offset(
//       radius * math.cos(angle) + radius,
//       radius * math.sin(angle) + radius,
//     );
//   }

//   double _timeToAngle(int hour, int minute) {
//     final totalMinutes = hour * 60 + minute;
//     return ((totalMinutes / 720) * 2 * math.pi) - (math.pi / 2); // Convert to radians and adjust
//   }

//   Widget _calculateSleepDuration(double startAngle, double endAngle) {
//     final totalMinutesStart = ((startAngle + (math.pi / 2)) / (2 * math.pi) * 720).round();
//     final totalMinutesEnd = ((endAngle + (math.pi / 2)) / (2 * math.pi) * 720).round();
//     int sleepMinutes = totalMinutesEnd - totalMinutesStart;

//     if (sleepMinutes < 0) {
//       sleepMinutes += 720;
//     }

//     final hours = sleepMinutes ~/ 60;
//     final minutes = sleepMinutes % 60;

//     return Column(
//       children: [
//         SizedBox(height: 16),
//         RichText(
//           text: TextSpan(
//             children: [
//               TextSpan(
//                 text: '${hours.toString().padLeft(2, '0')}',
//                 style: const TextStyle(
//                   fontSize: 30,
//                   fontWeight: FontWeight.w400,
//                   color: blue500,
//                   fontFamily: 'BoldCairo',
//                 ),
//               ),
//               const TextSpan(
//                 text: ' hrs ',
//                 style: TextStyle(
//                   fontSize: 13,
//                   fontWeight: FontWeight.normal,
//                   color: colorBlue,
//                 ),
//               ),
//               TextSpan(
//                 text: '${minutes.toString().padLeft(2, '0')}',
//                 style: const TextStyle(
//                   fontSize: 30,
//                   fontWeight: FontWeight.w400,
//                   color: blue500,
//                   fontFamily: 'BoldCairo',
//                 ),
//               ),
//               const TextSpan(
//                 text: ' mins',
//                 style: TextStyle(
//                   fontSize: 13,
//                   fontWeight: FontWeight.normal,
//                   color: colorBlue,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildHandle(double angle, double radius, bool isStartHandle, BuildContext context) {
//     return Transform.translate(
//       offset: Offset(
//         radius * math.cos(angle),
//         radius * math.sin(angle),
//       ),
//       child: GestureDetector(
//         onPanUpdate: (details) {
//           RenderBox box = context.findRenderObject() as RenderBox;
//           Offset localPosition = box.globalToLocal(details.globalPosition);
//           if (isStartHandle) {
//             final controller = Get.find<SleepTrackController>();
//             controller.updateStartAngle(_calculateAngle(localPosition, Size(radius * 2, radius * 2)));
//           } else {
//             final controller = Get.find<SleepTrackController>();
//             controller.updateEndAngle(_calculateAngle(localPosition, Size(radius * 2, radius * 2)));
//           }
//         },
//         child: Container(
//           width: 28,
//           height: 28,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             shape: BoxShape.circle,
//             border: Border.all(color: blue600, width: 6),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CircularSliderPainter extends CustomPainter {
//   final double startAngle;
//   final double endAngle;

//   CircularSliderPainter(this.startAngle, this.endAngle);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = colorBlue
//       ..strokeWidth = 12
//       ..style = PaintingStyle.stroke;

//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = size.width / 2;

//     if (endAngle >= startAngle) {
//       canvas.drawArc(
//         Rect.fromCircle(center: center, radius: radius),
//         startAngle,
//         endAngle - startAngle,
//         false,
//         paint,
//       );
//     } else {
//       canvas.drawArc(
//         Rect.fromCircle(center: center, radius: radius),
//         startAngle,
//         2 * math.pi - startAngle + endAngle,
//         false,
//         paint,
//       );
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
