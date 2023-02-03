import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';

import '../../constants/app_image.dart';
import '../../constants/ui_constants.dart';
import '../../contracts/enum/backgroundType.dart';

class BackgroundWrapper extends StatelessWidget {
  final Widget body;
  final BackgroundType backgroundType;
  const BackgroundWrapper({
    Key? key,
    required this.body,
    required this.backgroundType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (backgroundType == BackgroundType.notSet) return body;

    return Stack(
      key: key,
      alignment: AlignmentDirectional.topStart,
      children: [
        AnimatedBackgroundWrapper(backgroundType),
        body,
      ],
    );
  }
}

class AnimatedBackgroundWrapper extends StatefulWidget {
  final BackgroundType backgroundType;
  const AnimatedBackgroundWrapper(this.backgroundType, {Key? key})
      : super(key: key);

  @override
  createState() => _AnimatedBackgroundWidget();
}

class _AnimatedBackgroundWidget extends State<AnimatedBackgroundWrapper>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      behaviour: getFromType(widget.backgroundType),
      vsync: this,
      child: const Center(),
    );
  }
}

Behaviour getFromType(BackgroundType backgroundType) {
  switch (backgroundType) {
    case BackgroundType.patreon:
      return RandomParticleBehaviour(
        options: getParticleOptions(
          AppImage.specialPatreonLogo,
          spawnMaxSpeed: 20,
          spawnMinSpeed: 10,
          particleCount: 10,
        ),
      );
    case BackgroundType.valentines:
      return RandomParticleBehaviour(
        options: getParticleOptions(AppImage.heart),
      );
    case BackgroundType.christmas:
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
    image: Image.asset(image, package: UIConstants.commonPackage),
    spawnMaxSpeed: spawnMaxSpeed,
    spawnMinSpeed: spawnMinSpeed,
    particleCount: particleCount,
  );
  return options;
}
