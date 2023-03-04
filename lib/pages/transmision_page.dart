import 'package:flutter/material.dart';

import '../common/custom_web_view.dart';
import '../core/color_schemes.dart';
import '../models/transmision_model.dart';
import '../providers/transmision_provider.dart';

class TransmissionPage extends StatefulWidget {
  final int id;

  const TransmissionPage({Key? key, required this.id}) : super(key: key);

  @override
  State<TransmissionPage> createState() => _TransmissionPageState();
}

class _TransmissionPageState extends State<TransmissionPage> {
  Widget? _currentWidget;
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    TransmissionProvider transProvider = TransmissionProvider();

    return FutureBuilder(
      future: transProvider.getTransmission(widget.id),
      builder:
          (BuildContext context, AsyncSnapshot<TransmissionModel?> snapshot) {
        if (snapshot.hasData) {
          TransmissionModel? transmission = snapshot.data;
          if (transmission == null) {
            return const SizedBox.shrink();
          }

          _currentWidget ??= chat(transmission.chatUrl);

          return Scaffold(
            appBar: AppBar(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10, top: 5),
                  child: Text(
                    transmission.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        ?.copyWith(color: Colors.black),
                  ),
                ),
                Container(
                  height: 220,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  constraints: const BoxConstraints(maxHeight: 250),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: CustomWebView(transmission.videoCode),
                  ),
                ),
                bottomSelector(
                  chatUrl: transmission.chatUrl,
                  pollUrl: transmission.pollUrl,
                ),
                Expanded(child: _currentWidget ?? const SizedBox.shrink()),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget bottomSelector({required String chatUrl, required String pollUrl}) {
    List<Map<String, dynamic>> tabs = [
      {"title": 'Comentarios', "widget": chat(chatUrl)},
      {"title": "Encuesta", "widget": poll(pollUrl)}
    ];

    double totalWidth = MediaQuery.of(context).size.width;
    double tabWidth = totalWidth / tabs.length;

    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: tabs.map((tab) {
          int currentIndex = tabs.indexOf(tab);
          bool selected = currentIndex == _selectedTab;

          onTabFunction() {
            setState(() {
              _selectedTab = currentIndex;
              _currentWidget = tab["widget"];
            });
          }

          return _tab(tab["title"], onTabFunction, selected, tabWidth);
        }).toList(),
      ),
    );
  }

  Widget _tab(
      String title, void Function() onTap, bool selected, double width) {
    double borderRadius = 10;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: selected ? CustomColors().primaryLight : CustomColors().grey,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(borderRadius),
            topRight: Radius.circular(borderRadius),
          ),
        ),
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: selected ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget chat(String chatUrl) {
    return CustomWebView(chatUrl);
  }

  Widget poll(String pollUrl) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: CustomWebView(pollUrl),
    );
  }
}
