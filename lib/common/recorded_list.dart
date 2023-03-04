import 'package:tribuapp/models/prerecorded_model.dart';
import 'package:flutter/material.dart';

import '../pages/recorded_page.dart';
import '../utils/date_formatter.dart';
import 'schedule_expansion_card.dart';

class RecordedList extends StatelessWidget {
  final List<PrerecordedModel> recorded;

  const RecordedList({super.key, required this.recorded});
  @override
  Widget build(BuildContext context) {
    List<Widget> recordList = [];
    for (var record in recorded) {
      Color textColor = record.highlighted ? Colors.white : Colors.black87;
      recordList.add(ScheduleExpansionCard(
        header:
            DateFormatter.dateTimeToString(record.uploadDate ?? DateTime.now()),
        title: record.title,
        highlight: record.highlighted,
        hidden: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    record.category,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: textColor,
                        fontSize: 14,
                        fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    record.description,
                    textAlign: TextAlign.justify,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: textColor, fontSize: 16),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      child: Text(
                        "Ver",
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.copyWith(color: Colors.white),
                      ),
                      onPressed: () => _openRecord(context, record),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ));
    }
    recordList.add(const SizedBox(height: 35));

    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: recordList,
      ),
    );
  }

  _openRecord(BuildContext context, PrerecordedModel record) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecordedPage(
          record: record,
        ),
      ),
    );
  }
}
