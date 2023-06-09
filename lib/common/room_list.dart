import 'package:tribuapp/common/schedule_expansion_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

import '../models/room_model.dart';
import '../pages/transmision_page.dart';
import '../preferences/user_preferences.dart';
import '../utils/alert_dialog.dart';
import '../utils/date_formatter.dart';

class RoomList extends StatelessWidget {
  final List<RoomModel> rooms;

  const RoomList({super.key, required this.rooms});

  @override
  Widget build(BuildContext context) {
    final String baseUrl = GlobalConfiguration().getValue("api_url");
    final prefs = UserPreferences();
    final bool isPremiumUser = prefs.isPremium;

    List<Widget> roomList = [];

    for (var room in rooms) {
      String pictureUrl = baseUrl + room.picture;
      Widget roomAction;

      if (room.isMeeting) {
        roomAction = ElevatedButton(
          onPressed: () => {},
          child: Text(
            "Unirse a la reunión",
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(color: Colors.white),
          ),
        );
      } else {
        roomAction = ElevatedButton(
          child: Text(
            "En vivo",
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(color: Colors.white),
          ),
          onPressed: () => _openRoom(context, room),
        );
      }

      Widget roomWidget = ScheduleExpansionCard(
        header: DateFormatter.dateTimeToString(room.startDate),
        title: room.title,
        subtitle: room.description,
        highlight: room.isPrivate,
        hidden: Column(
          children: [
            CachedNetworkImage(
              imageUrl: pictureUrl,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(height: 15),
            SizedBox(
                width: MediaQuery.of(context).size.width, child: roomAction),
            const SizedBox(height: 10),
          ],
        ),
      );

      // Only add to list if it's premium user
      if (room.isPrivate && isPremiumUser) {
        roomList.add(roomWidget);
      } else {
        if (!room.isPrivate) {
          roomList.add(roomWidget);
        }
      }
    }

    roomList.add(const SizedBox(height: 35));
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: roomList,
      ),
    );
  }

  _openRoom(BuildContext context, RoomModel room) {
    DateTime now = DateTime.now();

    if (room.startDate.compareTo(now) < 0) {
      if (room.endDate.compareTo(now) > 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransmissionPage(id: room.id),
          ),
        );
      } else {
        showMyDialog(
          context,
          "El evento ya ha finalizado",
          Text(
            "Este evento ya ha finalizado.",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.black),
          ),
        );
      }
    } else {
      showMyDialog(
        context,
        "El evento no ha empezado",
        const Text(
            "Este evento aun no ha comenzado, intenta de nuevo más tarde."),
      );
    }
  }
}
