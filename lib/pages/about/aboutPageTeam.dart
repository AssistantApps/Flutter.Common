import 'package:flutter/material.dart';

import '../../assistantapps_flutter_common.dart';
import '../../constants/AppImage.dart';

class AboutPageTeam extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List.empty(growable: true);

    widgets.add(
      genericListTileWithNetworkImage(
        context,
        imageUrl: AppImage.teamPictureUrlKhaozTopsy,
        name: 'KhaozTopsy',
        subtitle: Text('Full Stack Developer'),
      ),
    );
    widgets.add(
      genericListTileWithNetworkImage(
        context,
        imageUrl: AppImage.teamPictureUrlRobo,
        name: 'Robo',
        subtitle: Text('App Developer'),
      ),
    );
    widgets.add(
      genericListTileWithNetworkImage(
        context,
        imageUrl: AppImage.teamPictureUrlLilo,
        name: 'LionessLilo',
        subtitle: Text('Graphic Designer'),
      ),
    );
    widgets.add(
      genericListTileWithNetworkImage(
        context,
        imageUrl: AppImage.teamPictureUrlSphynxcolt,
        name: 'Sphynxcolt',
        subtitle: Text('Discord Admin'),
      ),
    );
    widgets.add(emptySpace(1));

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      itemCount: widgets.length,
      itemBuilder: (_, int index) => widgets[index],
      shrinkWrap: true,
    );
  }
}