import 'package:flutter/cupertino.dart';

class CTimerPicker extends StatelessWidget {
  const CTimerPicker(
      {Key? key, required this.duration, required this.onTimerDurationChanged})
      : super(key: key);

  final Duration duration;
  final Function(Duration) onTimerDurationChanged;

  @override
  Widget build(BuildContext context) {
    return CupertinoTimerPicker(
      mode: CupertinoTimerPickerMode.hm,
      initialTimerDuration: duration,
      onTimerDurationChanged: onTimerDurationChanged,
    );
  }
}
