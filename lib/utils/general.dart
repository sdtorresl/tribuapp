import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL(url) async {
  print("Attempting to open $url...");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

Color getButtonColor(Set<MaterialState> states, BuildContext context) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Theme.of(context).primaryColor;
  }
  return Theme.of(context).colorScheme.secondary;
}
