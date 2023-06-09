import 'package:flutter/material.dart';

import '../core/color_schemes.dart';

class ScheduleExpansionCard extends StatefulWidget {
  final String? header;
  final String title;
  final String? subtitle;
  final Widget hidden;
  final Function()? onChanged;
  final bool highlight;

  const ScheduleExpansionCard({
    Key? key,
    this.header,
    this.subtitle,
    required this.title,
    required this.hidden,
    this.onChanged,
    this.highlight = false,
  }) : super(key: key);

  @override
  State<ScheduleExpansionCard> createState() => _ScheduleExpansionCardState();
}

class _ScheduleExpansionCardState extends State<ScheduleExpansionCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    Color textColor = widget.highlight ? Colors.white : Colors.black;
    Color iconColor = widget.highlight ? Colors.white : CustomColors().accent;

    List<Widget> headerItems;
    if (widget.header != null) {
      headerItems = <Widget>[
        const SizedBox(height: 17),
        Text(
          widget.header ?? '',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Colors.black38, fontSize: 13),
        ),
        const SizedBox(height: 4),
        Text(
          widget.title,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: textColor, fontWeight: FontWeight.w600, fontSize: 18),
        ),
        const SizedBox(height: 4),
      ];
    } else {
      headerItems = <Widget>[
        Text(
          widget.title,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: textColor, fontWeight: FontWeight.w600, fontSize: 18),
        ),
        const SizedBox(height: 17),
      ];
    }

    var expansionTile = Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        trailing: _expanded
            ? Icon(
                Icons.remove_circle_outline,
                color: iconColor,
              )
            : Icon(
                Icons.add_circle_outline,
                color: iconColor,
              ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: headerItems,
        ),
        subtitle: widget.subtitle != null
            ? Container(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Text(
                  widget.subtitle ?? '',
                  textAlign: TextAlign.justify,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(color: textColor, fontSize: 15),
                ),
              )
            : null,
        onExpansionChanged: (changed) {
          setState(() {
            _expanded = changed;
          });
          if (widget.onChanged != null) {
            widget.onChanged!();
          }
        },
        initiallyExpanded: _expanded,
        children: <Widget>[widget.hidden],
      ),
    );

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: widget.highlight ? CustomColors().primaryLight : Colors.white,
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: expansionTile,
      ),
    );
  }
}
