import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tribuapp/common/countdown.dart';
import 'package:tribuapp/common/event_description.dart';
import 'package:tribuapp/common/schedule_expansion_card.dart';
import 'package:tribuapp/models/event_model.dart';
import 'package:tribuapp/models/section_model.dart';
import 'package:tribuapp/utils/column_builder.dart';

import '../core/color_schemes.dart';
import '../providers/event_provider.dart';

class LobbyPage extends StatefulWidget {
  const LobbyPage({Key? key}) : super(key: key);

  @override
  State<LobbyPage> createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EventProvider eventProvider = EventProvider();

    return FutureBuilder(
      future: eventProvider.getEvent(),
      builder: (BuildContext context, AsyncSnapshot<EventModel?> snapshot) {
        if (snapshot.hasData) {
          EventModel event = snapshot.data!;
          List<SectionModel>? sections = event.sections;

          Widget description = Container(
            color: CustomColors().grey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                EventDescription(
                  title: event.title ?? '',
                  description: event.description ?? '',
                  picture: event.picture ?? '',
                ),
                Transform.translate(
                  offset: const Offset(0, -19),
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: CustomColors().grey,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );

          return ListView(
            children: [
              description,
              Container(
                decoration: BoxDecoration(
                  color: CustomColors().grey,
                ),
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 40),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        "Empieza nuestro conteo para el evento",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                      ),
                    ),
                    Countdown(startDate: event.startDate),
                    _sections(context, sections!),
                  ],
                ),
              ),
            ],
          );
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

  Widget _sections(context, List<SectionModel> sections) {
    return ColumnBuilder(
      itemCount: sections.length,
      itemBuilder: (context, index) {
        SectionModel section = sections[index];
        return ScheduleExpansionCard(
          title: section.title,
          hidden: Column(
            children: [
              Text(
                section.description,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: Colors.grey,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              CachedNetworkImage(
                imageUrl: section.picture,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ],
          ),
        );
      },
    );
  }
}
