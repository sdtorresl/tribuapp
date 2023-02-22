import 'package:flutter/material.dart';

import 'package:bmwapp/common/document_download.dart';
import 'package:bmwapp/models/document_model.dart';
import 'package:bmwapp/models/event_model.dart';
// import 'package:bmwapp/providers/event_provider.dart';

import '../main.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({Key? key}) : super(key: key);

  @override
  _DocumentsPageState createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: MyApp().accent,
        ),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        flexibleSpace: Container(
          padding: const EdgeInsets.only(left: 75),
          child: const Image(
            width: 300,
            image: AssetImage('assets/img/dots7.png'),
            repeat: ImageRepeat.repeat,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(243, 243, 243, 1),
        ),
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _mainTitle(context),
            const SizedBox(height: 20),
            // Expanded(
            //   child: _listDocuments(),
            // ),
          ],
        ),
      ),
    );
  }

  // Widget _listDocuments() {
  //   EventProvider eventProvider = EventProvider();
  //   return FutureBuilder(
  //     future: eventProvider.getEvent(),
  //     builder: (BuildContext context, AsyncSnapshot<EventModel> snapshot) {
  //       if (snapshot.hasData) {
  //         EventModel event = snapshot.data;
  //         print(event);
  //         List<DocumentModel> documents = event.documents;

  //         return _sections(context, documents);
  //       } else {
  //         return Container(
  //           height: 400,
  //           child: const Center(
  //             child: CircularProgressIndicator(),
  //           ),
  //         );
  //       }
  //     },
  //   );
  // }
}

Widget _sections(context, List<DocumentModel> documets) {
  print(documets);
  return ListView.builder(
    itemCount: documets.length,
    itemBuilder: (context, index) {
      DocumentModel document = documets[index];

      return DocumentDownload(
        url: document.url,
        title: document.title,
        description: document.description,
        type: document.type,
      );
    },
  );
}

Widget _mainTitle(context) {
  return Container(
    padding: const EdgeInsets.all(10),
    child: Text(
      "Biblioteca",
      style: Theme.of(context)
          .textTheme
          .displayLarge
          ?.copyWith(color: Colors.black),
    ),
  );
}
