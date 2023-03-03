import 'package:bmwapp/core/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmwapp/utils/general.dart';

class DocumentDownload extends StatefulWidget {
  final String title;
  final String description;
  final String? type;
  final String? url;
  final Function()? onChanged;

  const DocumentDownload({
    Key? key,
    required this.title,
    required this.description,
    required this.type,
    required this.url,
    this.onChanged,
  })  : assert(type != null),
        assert(url != null),
        super(key: key);

  @override
  State<DocumentDownload> createState() => _DocumentDownloadState();
}

class _DocumentDownloadState extends State<DocumentDownload> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    var expansionTile = ExpansionTile(
      trailing: _expanded
          ? const Icon(
              Icons.remove_circle_outline,
              color: Colors.pink,
            )
          : const Icon(
              Icons.add_circle_outline,
              color: Colors.pink,
            ),
      leading: const FaIcon(
        FontAwesomeIcons.filePdf,
        size: 30,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.title,
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(color: Colors.black, fontSize: 18),
            textAlign: TextAlign.start,
          ),
        ],
      ),
      onExpansionChanged: (changed) {
        setState(
          () {
            _expanded = changed;
          },
        );
        if (widget.onChanged != null) {
          widget.onChanged?.call();
        }
      },
      initiallyExpanded: _expanded,
      children: <Widget>[
        const SizedBox(height: 5),
        Text(
          widget.description,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: lightColorScheme.onPrimaryContainer),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: ElevatedButton(
            onPressed: () => launchURL(widget.url!),
            child: Text(
              'Descargar',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
      ],
    );

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: expansionTile,
      ),
    );
  }
}
