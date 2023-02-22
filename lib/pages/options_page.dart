// import 'package:flutter/material.dart';
// import 'package:icfes_two/common/options_card.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:icfes_two/common/social_icon.dart';
// import 'package:icfes_two/models/social_network_model.dart';
// import 'package:icfes_two/providers/social_network_provider.dart';

// class OptionsPage extends StatelessWidget {
//   const OptionsPage({required Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Color.fromRGBO(243, 243, 243, 1),
//       ),
//       padding: const EdgeInsets.only(right: 25, left: 25),
//       child: ListView(
//         children: <Widget>[
//           SizedBox(height: 25),
//           Text(
//             'Más opciones',
//             textAlign: TextAlign.left,
//             style: Theme.of(context)
//                 .textTheme
//                 .displayLarge
//                 ?.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
//           ),
//           SizedBox(height: 20.0),
//           OptionsCard(
//             title: 'Biblioteca',
//             icon: Icons.picture_as_pdf,
//             url: 'http://',
//             onTap: () => Navigator.of(context).pushNamed('documents'),
//           ),
//           // OptionsCard(
//           //   title: 'Video pósters',
//           //   icon: Icons.tv,
//           //   url: 'http://',
//           //   onTap: () {
//           //     print('push');
//           //     Navigator.of(context).pushNamed('video-posters');
//           //   },
//           // ),
//           _socialNetwork(context),
//           const SizedBox(
//             height: 35,
//           )
//         ],
//       ),
//     );
//   }

//   Widget _socialNetwork(context) {
//     final socialNetworkProvider = SocialNetworkProvider();

//     return FutureBuilder(
//       future: socialNetworkProvider.getSocialNetworks(),
//       builder: (context, AsyncSnapshot<SocialNetworkModel> snapshot) {
//         if (snapshot.hasData) {
//           SocialNetworkModel socialNetModel = snapshot.data;

//           List<Widget> socialNetworks = [];
//           if (socialNetModel.facebook != null) {
//             socialNetworks.add(SocialIcon(
//                 icon: const FaIcon(FontAwesomeIcons.facebook),
//                 url: snapshot.data.facebook.url));
//           }
//           if (socialNetModel.twitter != null) {
//             socialNetworks.add(SocialIcon(
//                 icon: const FaIcon(FontAwesomeIcons.twitter),
//                 url: snapshot.data.twitter.url));
//           }
//           if (socialNetModel.linkedin != null) {
//             socialNetworks.add(SocialIcon(
//                 icon: const FaIcon(FontAwesomeIcons.linkedin),
//                 url: snapshot.data.linkedin.url));
//           }
//           if (socialNetModel.instagram != null) {
//             socialNetworks.add(SocialIcon(
//                 icon: const FaIcon(FontAwesomeIcons.instagram),
//                 url: snapshot.data.instagram.url));
//           }
//           if (socialNetModel.youtube != null) {
//             socialNetworks.add(SocialIcon(
//                 icon: const FaIcon(FontAwesomeIcons.youtube),
//                 url: snapshot.data.youtube.url));
//           }

//           return Center(
//             child: Container(
//               width: MediaQuery.of(context).size.width * 0.6,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: socialNetworks,
//               ),
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
// }
