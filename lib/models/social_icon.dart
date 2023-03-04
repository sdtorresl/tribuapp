import 'package:bmwapp/core/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialIcon extends StatelessWidget {
  final Widget icon;
  final String url;

  const SocialIcon({Key? key, required this.icon, required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 50.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.tertiaryContainer),
      child: IconButton(
        icon: icon,
        color: Colors.white,
        onPressed: () => _openSocialUrl(),
      ),
    );
  }

  _openSocialUrl() async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
