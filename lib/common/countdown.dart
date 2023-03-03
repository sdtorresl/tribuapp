import 'package:flutter/material.dart';
import 'package:bmwapp/main.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class Countdown extends StatefulWidget {
  final DateTime? startDate;
  final String? title;

  const Countdown({Key? key, this.startDate, this.title}) : super(key: key);

  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width * 0.7,
      margin: const EdgeInsets.only(bottom: 20),
      child: CountdownTimer(
        endTime: widget.startDate?.millisecondsSinceEpoch,
        widgetBuilder: (_, time) {
          final remainingDays =
              time != null && time.days != null ? time.days : 0;
          final remainingHours =
              time != null && time.hours != null ? time.hours : 0;
          final remainingMins = time != null && time.min != null ? time.min : 0;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _counterItem(remainingDays.toString(), "Dias"),
              _counterItem(remainingHours.toString(), "Horas"),
              _counterItem(remainingMins.toString(), "Minutos"),
            ],
          );
        },
      ),
    );
  }

  Widget _counterItem(value, title) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          height: 75,
          width: 75,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: MyApp().primary,
            border: Border.all(color: const Color(0xff32c5ff), width: 5),
          ),
          child: Center(
            child: Text(
              value,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .displaySmall
              ?.copyWith(color: Colors.black26),
        ),
      ],
    );
  }
}
