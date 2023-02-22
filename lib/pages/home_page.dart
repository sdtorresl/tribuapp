import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bmwapp/common/expandable_fab.dart';
import 'package:bmwapp/common/fab_bottom_app_bar.dart';
import 'package:bmwapp/models/room_model.dart';
// import 'package:bmwapp/pages/schedule_page.dart';
import 'package:bmwapp/pages/lobby_page.dart';
import 'package:bmwapp/pages/rooms_page.dart';
// import 'package:bmwapp/pages/transmission_page.dart';
// import 'package:bmwapp/providers/rooms_provider.dart';
import 'options_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;
  // final roomsProvider = RoomsProvider();
  late AnimationController _animation;

  static List<Widget> _widgetOptions = <Widget>[
    const LobbyPage(),
    // RoomsPage(),
    // SchedulePage(),
    // OptionsPage(),
  ];

  void _onItemTapped(int index) {
    _tabController.animateTo(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    _tabController = TabController(vsync: this, length: _widgetOptions.length);
    _tabController.addListener(() {
      setState(() {
        if (_tabController.indexIsChanging ||
            (_tabController.animation?.value == _tabController.index)) {
          setState(() {
            _selectedIndex = _tabController.index;
          });
        }
      });
    });
    _animation = AnimationController(
      lowerBound: 0,
      upperBound: 1,
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _topBar(context),
      body: TabBarView(
        controller: _tabController,
        children: _widgetOptions,
      ),
      //_widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: FABBottomAppBar(
        backgroundColor: Colors.lightBlue,
        onTabSelected: _onItemTapped,
        selectedColor: Theme.of(context).colorScheme.secondary,
        color: Colors.grey,
        items: [
          FABBottomAppBarItem(iconData: Icons.home_outlined, text: 'Recepción'),
          FABBottomAppBarItem(
              iconData: Icons.people_alt_outlined, text: 'Salas'),
          FABBottomAppBarItem(iconData: Icons.today_outlined, text: 'Agenda'),
          FABBottomAppBarItem(iconData: Icons.more_horiz_outlined, text: 'Más'),
        ],
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FutureBuilder(
        // future: roomsProvider.getRooms(),
        builder:
            (BuildContext context, AsyncSnapshot<List<RoomModel>> snapshot) {
          if (snapshot.hasData) {
            List<Widget> rooms = [];

            for (var room in snapshot.data!) {
              rooms.add(
                Column(
                  children: [
                    // ActionButton(
                    //   onPressed: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => TransmissionPage(id: room.id),
                    //       ),
                    //     );
                    //   },
                    //   icon: const Icon(Icons.videocam),
                    // ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      room.title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 15),
                    ),
                  ],
                ),
              );
            }

            return ScaleTransition(
              scale: _animation,
              child: ExpandableFab(
                distance: 100,
                children: rooms,
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  PreferredSizeWidget _topBar(context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Orientation currentOrientation = MediaQuery.of(context).orientation;
    double barHeight = currentOrientation == Orientation.portrait ? 120 : 70;

    return PreferredSize(
      preferredSize: Size(screenWidth, barHeight),
      child: Container(
        width: screenWidth,
        padding: const EdgeInsets.all(5),
        child: SafeArea(
          child: Image.asset(
            "assets/img/icfes_app.png",
            width: screenWidth,
          ),
        ),
      ),
    );
  }
}
