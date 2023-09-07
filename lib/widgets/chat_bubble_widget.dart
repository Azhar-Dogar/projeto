import 'package:flutter/material.dart';
import 'package:projeto/extras/constants.dart';
import 'package:projeto/model/message_model.dart';

import '../extras/colors.dart';

class ChatBubbleWidget extends StatelessWidget {
  final MessageModel message;

  ChatBubbleWidget({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    bool isSender = message.senderId == Constants.uid();
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        constraints: const BoxConstraints(maxWidth: 250.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment:
                  isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: isSender ? CColors.primary : Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    message.message,
                    style: TextStyle(
                        color: isSender ? Colors.white : Colors.black),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: isSender ? null : 0,
              right: isSender ? 0 : null,
              child: CustomPaint(
                painter: TrianglePainter(
                  isUser: isSender,
                  bubbleColor: isSender ? CColors.primary : Colors.white,
                ),
                size: const Size(20, 20), // Adjust the size of the triangle
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final bool isUser;
  final Color bubbleColor;

  TrianglePainter({required this.isUser, required this.bubbleColor});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = bubbleColor;

    final double width = size.width;
    final double height = size.height;

    final Path path = Path();

    if (isUser) {
      path.moveTo(width, 30);
      path.lineTo(width - 10, height);
      path.lineTo(20, height - 10);
    } else {
      path.moveTo(height - 20, 32);
      path.lineTo(0, height - 10);
      path.lineTo(width - 10, height);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
