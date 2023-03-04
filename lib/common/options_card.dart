import 'package:flutter/material.dart';

class OptionsCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String url;
  final Function()? onTap;

  const OptionsCard(
      {Key? key,
      required this.title,
      required this.icon,
      required this.url,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      elevation: 2.0,
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        leading: Icon(icon, color: Colors.white),
        onTap: onTap,
        title: Text(title, style: Theme.of(context).textTheme.bodyText1),
      ),
    );
  }
}
