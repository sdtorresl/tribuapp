import 'package:bmwapp/providers/event_provider.dart';
import 'package:flutter/material.dart';

import 'package:bmwapp/common/document_download.dart';
import 'package:bmwapp/models/document_model.dart';
// import 'package:bmwapp/providers/event_provider.dart';

import '../models/event_model.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({Key? key}) : super(key: key);

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
            Expanded(
              child: _listDocuments(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listDocuments() {
    EventProvider eventProvider = EventProvider();
    return FutureBuilder(
      future: eventProvider.getEvent(),
      builder: (BuildContext context, AsyncSnapshot<EventModel?> snapshot) {
        if (snapshot.hasData) {
          EventModel event = snapshot.data!;

          if (event.documents == null) {
            return const SizedBox.shrink();
          }

          List<DocumentModel> documents = event.documents!;

          return _sections(context, documents);
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
}

Widget _sections(context, List<DocumentModel> documets) {
  return ListView.builder(
    itemCount: documets.length,
    itemBuilder: (context, index) {
      DocumentModel document = documets[index];

      return DocumentDownload(
        url: document.url,
        title: document.title ?? '',
        description: document.description ?? '',
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
