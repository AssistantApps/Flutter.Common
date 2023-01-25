import 'package:flutter/material.dart';

import '../../assistantapps_flutter_common.dart';
import '../../constants/AppImage.dart';

class AboutPageTeam extends StatelessWidget {
  const AboutPageTeam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List.empty(growable: true);

    widgets.add(
      genericListTileWithNetworkImage(
        context,
        imageUrl: AppImage.teamPictureUrlKhaozTopsy,
        name: 'KhaozTopsy',
        subtitle: const Text('Full Stack Developer'),
      ),
    );
    widgets.add(
      genericListTileWithNetworkImage(
        context,
        imageUrl: AppImage.teamPictureUrlRobo,
        name: 'Robo',
        subtitle: const Text('App Developer'),
      ),
    );
    widgets.add(
      genericListTileWithNetworkImage(
        context,
        imageUrl: AppImage.teamPictureUrlLilo,
        name: 'LionessLilo',
        subtitle: const Text('Graphic Designer'),
      ),
    );
    widgets.add(
      genericListTileWithNetworkImage(
        context,
        imageUrl: AppImage.teamPictureUrlSphynxcolt,
        name: 'Sphynxcolt',
        subtitle: const Text('Discord Admin'),
      ),
    );
    widgets.add(
      genericListTileWithNetworkImage(
        context,
        imageUrl: AppImage.teamPictureUrlLenni,
        name: 'Lenni',
        subtitle: const Text('German Translator | Bug finder | NMS Expert'),
      ),
    );
    widgets.add(
      genericListTileWithNetworkImage(
        context,
        imageUrl: AppImage.teamPictureUrlCyberpunk,
        name: 'Cyberpunk2350',
        subtitle: const Text(
            'Moderator | NMS Dataminer | Keeper of Obscure Knowledge'),
      ),
    );
    widgets.add(emptySpace(1));

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      itemCount: widgets.length,
      itemBuilder: (_, int index) => widgets[index],
      shrinkWrap: true,
    );
  }
}
