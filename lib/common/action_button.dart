import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final double? width;

  const ActionButton({Key? key, this.onPressed, required this.text, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ElevatedButton(
      onPressed: onPressed,
      child: SizedBox(
        width: width ?? size.width * 0.5,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.copyWith(color: Colors.white),
            ),
            Icon(
              Icons.arrow_forward_outlined,
              color: Colors.yellow[600],
            )
          ],
        ),
      ),
    );
  }
}
