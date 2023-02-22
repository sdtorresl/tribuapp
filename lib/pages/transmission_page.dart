// import 'package:flutter/material.dart';
// import 'package:bmwapp/common/custom_webview.dart';
// import 'package:bmwapp/main.dart';
// import 'package:bmwapp/models/transmission_model.dart';
// import 'package:bmwapp/providers/transmission_provider.dart';

// class TransmissionPage extends StatefulWidget {
//   final int id;

//   const TransmissionPage({required Key key, required this.id})
//       : super(key: key);

//   @override
//   _TransmissionPageState createState() => _TransmissionPageState();
// }

// class _TransmissionPageState extends State<TransmissionPage> {
//   Widget _currentWidget;
//   int _selectedTab = 0;

//   @override
//   Widget build(BuildContext context) {
//     TransmissionProvider transProvider = TransmissionProvider();

//     return FutureBuilder(
//       future: transProvider.getTransmission(widget.id),
//       builder:
//           (BuildContext context, AsyncSnapshot<TransmissionModel> snapshot) {
//         if (snapshot.hasData) {
//           TransmissionModel transmission = snapshot.data;
//           if (_currentWidget == null) {
//             _currentWidget = chat(transmission.chatUrl);
//           }

//           return Scaffold(
//             appBar: AppBar(
//               iconTheme: IconThemeData(
//                 color: const MyApp().accent,
//               ),
//               shadowColor: Colors.transparent,
//               backgroundColor: Colors.white,
//               flexibleSpace: Container(
//                 padding: const EdgeInsets.only(left: 75),
//                 child: const Image(
//                   width: 300,
//                   image: AssetImage('assets/img/dots7.png'),
//                   repeat: ImageRepeat.repeat,
//                 ),
//               ),
//             ),
//             body: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Container(
//                   margin: const EdgeInsets.only(bottom: 10, top: 5),
//                   child: Text(
//                     transmission.title,
//                     textAlign: TextAlign.center,
//                     style: Theme.of(context)
//                         .textTheme
//                         .displayMedium
//                         .copyWith(color: Colors.black),
//                   ),
//                 ),
//                 Container(
//                   height: 220,
//                   color: IcfesApp().grey,
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   constraints: const BoxConstraints(maxHeight: 250),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(15.0),
//                     child: CustomWebView(transmission.videoCode),
//                   ),
//                 ),
//                 bottomSelector(
//                   chatUrl: transmission.chatUrl,
//                   pollUrl: transmission.pollUrl,
//                 ),
//                 Expanded(child: _currentWidget),
//               ],
//             ),
//           );
//         } else {
//           return Center(
//             child: const CircularProgressIndicator(),
//           );
//         }
//       },
//     );
//   }

//   Widget bottomSelector({String chatUrl, String pollUrl}) {
//     List<Map<String, dynamic>> tabs = [
//       {"title": 'Comentarios', "widget": chat(chatUrl)},
//       {"title": "Encuesta", "widget": poll(pollUrl)}
//     ];

//     double totalWidth = MediaQuery.of(context).size.width;
//     double tabWidth = totalWidth / tabs.length;

//     return Container(
//       margin: const EdgeInsets.only(top: 15),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: tabs.map((tab) {
//           int currentIndex = tabs.indexOf(tab);
//           bool selected = currentIndex == _selectedTab;

//           Function onTabFunction = () {
//             setState(() {
//               _selectedTab = currentIndex;
//               _currentWidget = tab["widget"];
//             });
//           };

//           return _tab(tab["title"], onTabFunction, selected, tabWidth);
//         }).toList(),
//       ),
//     );
//   }

//   Widget _tab(String title, Function onTap, bool selected, double width) {
//     double borderRadius = 10;

//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: width,
//         decoration: BoxDecoration(
//           color: selected ? IcfesApp().primaryLight : IcfesApp().grey,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(borderRadius),
//             topRight: Radius.circular(borderRadius),
//           ),
//         ),
//         padding: const EdgeInsets.all(15),
//         child: Text(
//           title,
//           textAlign: TextAlign.center,
//           style: Theme.of(context)
//               .textTheme
//               .bodyLarge
//               ?.copyWith(color: selected ? Colors.white : Colors.black),
//         ),
//       ),
//     );
//   }

//   Widget chat(String chatUrl) {
//     return CustomWebView(chatUrl);
//   }

//   Widget poll(String pollUrl) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       child: CustomWebView(pollUrl),
//     );
//   }
// }
