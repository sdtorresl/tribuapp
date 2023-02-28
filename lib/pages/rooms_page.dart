import 'package:flutter/material.dart';
import 'package:bmwapp/common/recorded_list.dart';
import 'package:bmwapp/common/room_list.dart';
import 'package:bmwapp/main.dart';
import 'package:bmwapp/providers/prerecorded_provider.dart';
import 'package:bmwapp/providers/rooms_provider.dart';

import '../models/prerecorded_model.dart';
import '../models/room_model.dart';

class RoomsPage extends StatefulWidget {
  const RoomsPage({Key? key}) : super(key: key);
  @override
  State<RoomsPage> createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  @override
  void initState() {
    super.initState();

    _currentWidget = roomSelector(context);
  }

  late Widget _currentWidget;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      transitionBuilder: (child, animation) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;

        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      child: _currentWidget,
    );
  }

  Widget roomSelector(context) {
    return Scaffold(
      body: Center(
        child: ListView(children: [
          SizedBox(
            // ignore: sort_child_properties_last
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: const Text(
                'Selecciona la Sala',
                style: TextStyle(
                    fontSize: 22.0,
                    fontFamily: 'PoppinsMedium',
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            height: 50,
          ),
          Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            color: MyApp().primary,
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              title: const Text(
                "En vivo ahora mismo",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'PoppinsMedium',
                ),
              ),
              subtitle: const Text(
                  "¡Conéctate con el #saber y la #investigación!",
                  style: TextStyle(fontFamily: 'Montserrat')),
              trailing: const Icon(
                Icons.video_call,
                color: Colors.white,
                size: 50,
              ),
              onTap: () {
                setState(() => {_currentWidget = roomList(context)});
              },
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            color: Colors.deepPurpleAccent,
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              title: const Text(
                "Galería de experiencias",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'PoppinsMedium',
                ),
              ),
              subtitle: const Text("¡Encuentra aquí Experiencias que motivan!",
                  style: TextStyle(fontFamily: 'Montserrat')),
              trailing: const Icon(
                Icons.photo_album,
                color: Colors.white,
                size: 50,
              ),
              enabled: true,
              onTap: () {
                setState(() => {_currentWidget = recordedList(context)});
              },
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ]),
      ),
    );
  }

  Widget roomList(context) {
    final roomsProvider = RoomsProvider();
    return Container(
      color: const Color.fromRGBO(243, 243, 243, 1),
      child: ListView(children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 20, right: 25, left: 25),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() => {_currentWidget = roomSelector(context)});
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: MyApp().accent,
                  size: 40,
                ),
              ),
              const Text(
                "En vivo ahora mismo",
                style: TextStyle(
                  fontSize: 22.0,
                  fontFamily: 'PoppinsMedium',
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FutureBuilder(
            future: roomsProvider.getRooms(),
            builder: (BuildContext context,
                AsyncSnapshot<List<RoomModel>> snapshot) {
              if (snapshot.hasData) {
                return RoomList(rooms: snapshot.data!);
              } else {
                return const SizedBox(
                  height: 400,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ),
      ]),
    );
  }

  Widget recordedList(context) {
    final prerecordedProvider = PrerecordedProvider();
    return Container(
      color: const Color.fromRGBO(243, 243, 243, 1),
      child: ListView(children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 20, right: 25, left: 25),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() => {_currentWidget = roomSelector(context)});
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: MyApp().accent,
                  size: 40,
                ),
              ),
              const Text(
                "Galería de experiencias",
                style: TextStyle(
                  fontSize: 22.0,
                  fontFamily: 'PoppinsMedium',
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: const Color.fromRGBO(243, 243, 243, 1),
          child: FutureBuilder(
            future: prerecordedProvider.getPrerecorded(),
            builder: (BuildContext context,
                AsyncSnapshot<List<PrerecordedModel>> snapshot) {
              if (snapshot.hasData) {
                return RecordedList(
                  recorded: snapshot.data!,
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
          ),
        ),
      ]),
    );
  }

  Widget historicList(context) {
    final prerecordedProvider = PrerecordedProvider();
    return ListView(children: <Widget>[
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        color: const Color.fromRGBO(243, 243, 243, 1),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  setState(() => {_currentWidget = roomSelector(context)});
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: MyApp().accent,
                  size: 40,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Sala Colombia",
                style: TextStyle(
                    fontSize: 22.0,
                    fontFamily: 'PoppinsMedium',
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ]),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: const Color.fromRGBO(243, 243, 243, 1),
        child: FutureBuilder(
          future: prerecordedProvider.getHistoric(),
          builder: (BuildContext context,
              AsyncSnapshot<List<PrerecordedModel>> snapshot) {
            if (snapshot.hasData) {
              return RecordedList(
                recorded: snapshot.data!,
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
        ),
      ),
    ]);
  }
}
