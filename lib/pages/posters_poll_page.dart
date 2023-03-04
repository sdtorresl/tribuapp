import 'package:flutter/material.dart';
import 'package:bmwapp/common/action_button.dart';
import 'package:bmwapp/preferences/user_preferences.dart';
// import 'package:bmwapp/providers/poster_provider.dart';
import 'package:bmwapp/utils/alert_dialog.dart';

import '../core/color_schemes.dart';
import '../models/video_poster_model.dart';
import '../providers/posters_provider.dart';
import '../utils/column_builder.dart';

class PostersPollPage extends StatefulWidget {
  const PostersPollPage({Key? key}) : super(key: key);

  @override
  State<PostersPollPage> createState() => _PostersPollPageState();
}

class _PostersPollPageState extends State<PostersPollPage> {
  int? _selectedPoster;
  final posterProvider = PosterProvider();
  final _prefs = UserPreferences();

  @override
  void initState() {
    _selectedPoster = _prefs.selectedPoster;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Participa en nuestra votación de los pósters',
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(color: Colors.black),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: CustomColors().primary,
                borderRadius: BorderRadius.circular(10),
              ),
              width: size.width,
              child: Text(
                "¿Cúal es el video póster que más te gustó?\nSelecciona tu respuesta",
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: posterProvider.getPosters(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<VideoPosterModel>> snapshot) {
                  if (snapshot.hasData) {
                    return _posterSelector(snapshot.data!);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            ActionButton(
              text: "Votar por el mejor póster",
              width: size.width,
              onPressed: _selectedPoster == null ? null : () => _sendVote(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _posterSelector(List<VideoPosterModel> data) {
    return SingleChildScrollView(
      child: ColumnBuilder(
        itemBuilder: (context, index) {
          int currentPoster = int.parse(data[index].id);

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedPoster = currentPoster;
                _prefs.selectedPoster = _selectedPoster!;
              });
            },
            child: Row(
              children: [
                Icon(
                  currentPoster == _selectedPoster
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: currentPoster == _selectedPoster
                      ? CustomColors().primary
                      : Colors.black,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      data[index].titulo!,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: currentPoster == _selectedPoster
                              ? CustomColors().primary
                              : Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: data.length,
      ),
    );
  }

  void _sendVote() async {
    if (_prefs.posterVoted == true) {
      showMyDialog(
        context,
        "Voto enviado",
        const Text(
            "Tu voto ya ha sido registrado, muchas gracias por participar"),
      );
      return;
    }

    bool voted = await posterProvider.votePoster(_selectedPoster);
    _prefs.posterVoted = voted;

    if (voted) {
      // ignore: use_build_context_synchronously
      showMyDialog(
        context,
        "Voto enviado",
        const Text("Muchas gracias por participar"),
      );
    } else {
      // ignore: use_build_context_synchronously
      showMyDialog(
        context,
        "Error",
        const Text(
            "Tu voto no pudo ser registrado, por favor intenta de nuevo en unos minutos."),
      );
    }
  }
}
