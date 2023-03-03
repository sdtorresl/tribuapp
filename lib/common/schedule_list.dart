import 'package:bmwapp/common/schedule_expansion_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

import '../models/schedule_model.dart';
import '../pages/transmision_page.dart';
import '../utils/date_formatter.dart';
import 'action_button.dart';

class ScheduleList extends StatelessWidget {
  final List<ScheduleModel> schedules;

  const ScheduleList({super.key, required this.schedules});

  @override
  Widget build(BuildContext context) {
    final String baseUrl = GlobalConfiguration().getValue("api_url");

    return ListView.builder(
      itemCount: schedules.length,
      itemBuilder: (context, index) {
        ScheduleModel schedule = schedules[index];

        String pictureUrl = baseUrl + schedule.picture;
        List<Widget> hiddenItems = [
          CachedNetworkImage(
            imageUrl: pictureUrl,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ];

        if (int.tryParse(schedule.room) != null &&
            schedule.startDate.compareTo(DateTime.now()) <= 0 &&
            schedule.endDate.compareTo(DateTime.now()) >= 0) {
          hiddenItems.add(const SizedBox(
            height: 10,
          ));
          hiddenItems.add(
            ActionButton(
              text: "Ver ahora",
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TransmissionPage(
                    id: int.parse(schedule.room),
                  ),
                ),
              ),
              width: double.infinity,
            ),
          );
        }

        return ScheduleExpansionCard(
          header: DateFormatter.dateTimeToString(schedules[index].startDate),
          title: schedule.title,
          subtitle: schedule.description,
          hidden: Column(
            children: hiddenItems,
          ),
        );
      },
    );
  }
}
