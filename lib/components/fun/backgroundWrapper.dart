import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';

import '../../contracts/enum/backgroundType.dart';
import '../../constants/AppImage.dart';

class BackgroundWrapper extends StatelessWidget {
  final Widget body;
  final BackgroundType backgroundType;
  BackgroundWrapper({
    @required this.body,
    @required this.backgroundType,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBackgroundWrapper(this.backgroundType),
        this.body,
      ],
    );
  }
}

class AnimatedBackgroundWrapper extends StatefulWidget {
  final BackgroundType backgroundType;
  AnimatedBackgroundWrapper(this.backgroundType);

  @override
  _AnimatedBackgroundWidget createState() => _AnimatedBackgroundWidget(
        this.backgroundType,
      );
}

class _AnimatedBackgroundWidget extends State<AnimatedBackgroundWrapper>
    with TickerProviderStateMixin {
  final BackgroundType backgroundType;
  _AnimatedBackgroundWidget(this.backgroundType);

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      behaviour: getFromType(this.backgroundType),
      vsync: this,
      child: Center(),
    );
  }
}

Behaviour getFromType(BackgroundType backgroundType) {
  switch (backgroundType) {
    case BackgroundType.Patreon:
      return RandomParticleBehaviour(
        options: getParticleOptions(
          AppImage.specialPatreonLogo,
          spawnMaxSpeed: 20,
          spawnMinSpeed: 10,
          particleCount: 10,
        ),
      );
    case BackgroundType.Christmas:
    default:
      return RandomParticleBehaviour(
        options: getParticleOptions(AppImage.snowflake),
      );
  }
}

ParticleOptions getParticleOptions(
  String image, {
  double spawnMaxSpeed = 25,
  double spawnMinSpeed = 15,
  int particleCount = 50,
}) {
  ParticleOptions options = ParticleOptions(
    image: Image.asset(image, package: UIConstants.CommonPackage),
    spawnMaxSpeed: spawnMaxSpeed,
    spawnMinSpeed: spawnMinSpeed,
    particleCount: particleCount,
  );
  return options;
}
