import 'package:flutter/material.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';

import '../models/prerecorded_model.dart';

class RecordedPage extends StatefulWidget {
  final PrerecordedModel record;

  const RecordedPage({Key? key, required this.record}) : super(key: key);

  @override
  State<RecordedPage> createState() => _RecordedPageState();
}

class _RecordedPageState extends State<RecordedPage> {
  @override
  Widget build(BuildContext context) {
    debugPrint(widget.record.toJson());
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              widget.record.title,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  ?.copyWith(color: Colors.black),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            height: 250,
            color: Colors.transparent,
            child: VimeoPlayer(
              videoId: widget.record.videoCode,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              widget.record.description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3,
            ),
          )
        ],
      ),
    );
  }
}
