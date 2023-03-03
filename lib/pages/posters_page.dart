import 'package:flutter/material.dart';
import 'package:bmwapp/common/action_button.dart';
import 'package:bmwapp/common/poster_view.dart';

import '../providers/posters_provider.dart';
// import 'package:bmwapp/providers/poster_provider.dart';

class PostersPage extends StatelessWidget {
  const PostersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _posterTitle(context),
            Expanded(child: _listPoster(context)),
            ActionButton(
              text: "Votar por el mejor póster",
              width: MediaQuery.of(context).size.width * 0.9,
              onPressed: () => {
                Navigator.pushNamed(context, 'video-posters-poll'),
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _posterTitle(context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Text(
        'Video Pósters',
        textAlign: TextAlign.left,
        style: Theme.of(context)
            .textTheme
            .displayLarge
            ?.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _listPoster(context) {
    final posterProvider = PosterProvider();
    return FutureBuilder(
      future: posterProvider.getPosters(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return PosterList(posters: snapshot.data);
        } else {
          return const SizedBox(
            height: 400,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
