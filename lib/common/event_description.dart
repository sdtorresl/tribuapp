import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EventDescription extends StatelessWidget {
  final String title;
  final String description;
  final String picture;

  const EventDescription(
      {Key? key, this.title = '', this.description = '', this.picture = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final card = Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(30),
          child: Text(
            title.toString(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
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
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        )
      ],
    );

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Theme.of(context).colorScheme.primary,
          Theme.of(context).colorScheme.secondary,
        ],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      )),
      child: card,
    );
  }
}
