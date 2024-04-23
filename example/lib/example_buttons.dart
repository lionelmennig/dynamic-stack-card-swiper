import 'dart:math';

import 'package:dynamic_stack_card_swiper/dynamic_stack_card_swiper.dart';
import 'package:dynamic_stack_card_swiper/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'example_candidate_model.dart';

//swipe card to the right side
Widget swipeRightButton(DynamicStackCardSwiperController controller) {
  // We can listen to the controller to get updated as the card shifts position!
  return ListenableBuilder(
    listenable: controller,
    builder: (context, child) {
      final SwiperPosition? position = controller.position;
      final SwiperActivity? activity = controller.swipeActivity;
      // Lets measure the progress of the swipe iff it is a horizontal swipe.
      final double progress = (activity is Swipe || activity == null) &&
              position != null &&
              position.offset.toAxisDirection().isHorizontal
          ? position.progressRelativeToThreshold.clamp(-1, 1)
          : 0;
      // Lets animate the button according to the
      // progress. Here we'll color the button more grey as we swipe away from
      // it.
      final Color color = Color.lerp(
        CupertinoColors.activeGreen,
        CupertinoColors.systemGrey2,
        (-1 * progress).clamp(0, 1),
      )!;
      return GestureDetector(
        onTap: () => (controller.size ?? 0) > 0 ? controller.swipeRight() : null,
        child: Transform.scale(
          scale: 1 + .1 * progress.clamp(0, 1),
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.9),
                  spreadRadius: -10,
                  blurRadius: 20,
                  offset: const Offset(0, 20), // changes position of shadow
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.check,
              color: CupertinoColors.white,
              size: 40,
            ),
          ),
        ),
      );
    },
  );
}

//swipe card to the left side
Widget swipeLeftButton(DynamicStackCardSwiperController controller) {
  return ListenableBuilder(
    listenable: controller,
    builder: (context, child) {
      final SwiperPosition? position = controller.position;
      final SwiperActivity? activity = controller.swipeActivity;
      final double horizontalProgress =
          (activity is Swipe || activity == null) &&
                  position != null &&
                  position.offset.toAxisDirection().isHorizontal
              ? -1 * position.progressRelativeToThreshold.clamp(-1, 1)
              : 0;
      final Color color = Color.lerp(
        const Color(0xFFFF3868),
        CupertinoColors.systemGrey2,
        (-1 * horizontalProgress).clamp(0, 1),
      )!;
      return GestureDetector(
        onTap: () => (controller.size ?? 0) > 0 ? controller.swipeLeft() : null,
        child: Transform.scale(
          // Increase the button size as we swipe towards it.
          scale: 1 + .1 * horizontalProgress.clamp(0, 1),
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.9),
                  spreadRadius: -10,
                  blurRadius: 20,
                  offset: const Offset(0, 20), // changes position of shadow
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.close,
              color: CupertinoColors.white,
            ),
          ),
        ),
      );
    },
  );
}

// Add entry button
Widget addEntryButton(DynamicStackCardSwiperController controller) {
  return ElevatedButton.icon(
    onPressed: () {
      controller.addCardOnTop(
        ExampleCandidateModel(
          name: 'Item n°${increment++}',
          job: 'Manager',
          city: 'Town',
          color: getRandomGradient(),
        ),
        getRandomAxis(),
      );
    },
    icon: Icon(Icons.add),
    label: Text("Add a new card"),
  );
}

int increment = 1;

LinearGradient getRandomGradient() {
  return gradientsList[Random().nextInt(gradientsList.length - 1)];
}

AxisDirection getRandomAxis() {
  return AxisDirection.values[Random().nextInt(AxisDirection.values.length - 1)];
}

class TutorialAnimationButton extends StatelessWidget {
  const TutorialAnimationButton(this.onTap, {super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(
        Icons.question_mark,
        color: CupertinoColors.systemGrey2,
      ),
    );
  }
}
