import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EventDescription extends StatelessWidget {
  final String title;
  final String description;
  final String picture;

  const EventDescription(
      {Key? key,
      required this.title,
      required this.description,
      required this.picture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final card = Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(30),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        CachedNetworkImage(
          imageUrl: picture,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const SizedBox(
            height: 50,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(50),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        )
      ],
    );

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: AssetImage("assets/img/Group 194.png"),
        ),
      ),
      child: card,
    );
  }
}
