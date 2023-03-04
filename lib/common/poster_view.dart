import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tribuapp/common/video_poster.dart';

import 'package:tribuapp/models/video_poster_model.dart';

class PosterList extends StatelessWidget {
  final List<VideoPosterModel> posters;

  const PosterList({super.key, required this.posters});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        itemCount: posters.length,
        itemBuilder: (context, index) {
          log(posters[index].toString());
          return PosterView(
            video: posters[index].videos.url,
            title: posters[index].titulo!,
            subtitle: posters[index].descripcion!,
            attachment: posters[index].imagen,
          );
        },
      ),
    );
  }
}
