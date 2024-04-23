import 'dart:developer';

import 'package:dynamic_stack_card_swiper/dynamic_stack_card_swiper.dart';
import 'package:dynamic_stack_card_swiper/enums.dart';
import 'package:example/example_candidate_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'example_buttons.dart';
import 'example_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: Example(),
    );
  }
}

class Example extends StatefulWidget {
  const Example({
    Key? key,
  }) : super(key: key);

  @override
  State<Example> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<Example> {
  final DynamicStackCardSwiperController<ExampleCandidateModel> controller = DynamicStackCardSwiperController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 50.0),
              child: addEntryButton(controller),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .75,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                  right: 25,
                  top: 50,
                  bottom: 40,
                ),
                child: DynamicStackCardSwiper<ExampleCandidateModel>(
                  invertAngleOnBottomDrag: true,
                  backgroundCardCount: 3,
                  swipeOptions: const SwipeOptions.all(),
                  controller: controller,
                  onCardPositionChanged: (
                    SwiperPosition position,
                  ) {
                    //debugPrint('${position.offset.toAxisDirection()}, '
                    //    '${position.offset}, '
                    //    '${position.angle}');
                  },
                  onSwipeEnd: _swipeEnd,
                  onEnd: _onEnd,
                  cardBuilder: (context, item) {
                    return ExampleCard(candidate: item);
                  },
                ),
              ),
            ),
            IconTheme.merge(
              data: const IconThemeData(size: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TutorialAnimationButton(_shakeCard),
                  const SizedBox(
                    width: 20,
                  ),
                  swipeLeftButton(controller),
                  const SizedBox(
                    width: 20,
                  ),
                  swipeRightButton(controller),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _swipeEnd(ExampleCandidateModel? previousModel, ExampleCandidateModel? targetModel, SwiperActivity activity) {
    switch (activity) {
      case Swipe():
        log('The card was swiped to the : ${activity.direction}');
        log('previous model: ${previousModel?.name ?? "none"}, target model: ${targetModel?.name ?? "none"}');
        break;
      case AddCardOnTop():
        log('A new model was added from : ${activity.direction.name}');
        log('previous model: ${previousModel?.name ?? "none"}, target model: ${targetModel?.name ?? "none"}');
        break;
      case CancelSwipe():
        log('A swipe was cancelled');
        break;
      case DrivenActivity():
        log('Driven Activity');
        break;
    }
  }

  void _onEnd() {
    log('end reached!');
  }

  // Animates the card back and forth to teach the user that it is swipable.
  Future<void> _shakeCard() async {
    if (controller.size == null || controller.size! == 0) {
      return;
    }

    const double distance = 30;
    // We can animate back and forth by chaining different animations.
    await controller.animateTo(
      const Offset(-distance, 0),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
    await controller.animateTo(
      const Offset(distance, 0),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    // We need to animate back to the center because `animateTo` does not center
    // the card for us.
    await controller.animateTo(
      const Offset(0, 0),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }
}
