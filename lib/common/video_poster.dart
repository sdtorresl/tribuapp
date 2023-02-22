import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PosterView extends StatefulWidget {
  final video;
  final String title;
  final String subtitle;
  final String? attachment;

  const PosterView({
    super.key,
    required this.video,
    required this.title,
    required this.subtitle,
    this.attachment,
  });

  @override
  _PosterViewState createState() => _PosterViewState();
}

class _PosterViewState extends State<PosterView> {
  @override
  Widget build(BuildContext context) {
    if (widget.video == null || widget.video == "" || widget.video == "false") {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text("No se pudo cargar el poster"),
        ),
      );
    }
    print(widget.video);

    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.video)!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    var expansionTile = ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Align(
                alignment: Alignment.topLeft,
                widthFactor: 1,
                heightFactor: 1,
                child: YoutubePlayerBuilder(
                  player: YoutubePlayer(
                    controller: _controller,
                  ),
                  builder: (context, player) {
                    return Column(
                      children: [
                        player,
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
            child: Text(
              widget.title,
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
            ),
          ),
        ],
      ),
      subtitle: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.subtitle,
              textAlign: TextAlign.justify,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontSize: 16),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
            ),
            InkWell(
              onTap: () => _downloadAttachment(widget.attachment),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Descargar',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: Colors.pink,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  const FaIcon(FontAwesomeIcons.cloudArrowDown,
                      color: Colors.pink),
                  const Padding(
                    padding: EdgeInsets.all(19),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: expansionTile,
      ),
    );
  }

  void _downloadAttachment(url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
