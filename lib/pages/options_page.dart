import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../common/options_card.dart';
import '../models/social_icon.dart';
import '../models/social_network_model.dart';
import '../providers/social_network_provider.dart';

class OptionsPage extends StatelessWidget {
  const OptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(243, 243, 243, 1),
      ),
      padding: const EdgeInsets.only(right: 25, left: 25),
      child: ListView(
        children: <Widget>[
          const SizedBox(height: 25),
          Text(
            'Más opciones',
            textAlign: TextAlign.left,
            style: Theme.of(context)
                .textTheme
                .headline1
                ?.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20.0),
          OptionsCard(
            title: 'Indicadores del evento',
            icon: Icons.picture_as_pdf,
            url: 'http://',
            onTap: () => Navigator.of(context).pushNamed('documents'),
          ),
          OptionsCard(
            title: 'Recursos adicionales',
            icon: Icons.tv,
            url: 'http://',
            onTap: () {
              Navigator.of(context).pushNamed('video-posters');
            },
          ),
          _socialNetwork(context),
          const SizedBox(
            height: 35,
          )
        ],
      ),
    );
  }

  Widget _socialNetwork(context) {
    final socialNetworkProvider = SocialNetworkProvider();

    return FutureBuilder(
      future: socialNetworkProvider.getSocialNetworks(),
      builder: (context, AsyncSnapshot<SocialNetworkModel?> snapshot) {
        if (snapshot.hasData) {
          SocialNetworkModel? socialNetModel = snapshot.data;

          if (socialNetModel == null) {
            return const SizedBox.shrink();
          }

          List<Widget> socialNetworks = [];
          if (socialNetModel.facebook != null) {
            socialNetworks.add(SocialIcon(
                icon: const FaIcon(FontAwesomeIcons.facebook),
                url: socialNetModel.facebook!.url));
          }
          if (socialNetModel.twitter != null) {
            socialNetworks.add(SocialIcon(
                icon: const FaIcon(FontAwesomeIcons.twitter),
                url: socialNetModel.twitter!.url));
          }
          if (socialNetModel.linkedin != null) {
            socialNetworks.add(
              SocialIcon(
                icon: const FaIcon(FontAwesomeIcons.linkedin),
                url: socialNetModel.linkedin!.url,
              ),
            );
          }
          if (socialNetModel.instagram != null) {
            socialNetworks.add(
              SocialIcon(
                icon: const FaIcon(FontAwesomeIcons.instagram),
                url: socialNetModel.instagram!.url,
              ),
            );
          }
          if (socialNetModel.youtube != null) {
            socialNetworks.add(
              SocialIcon(
                icon: const FaIcon(FontAwesomeIcons.youtube),
                url: socialNetModel.youtube!.url,
              ),
            );
          }

          return Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: socialNetworks,
              ),
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
}
