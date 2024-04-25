import 'dart:developer';

import 'package:dynamic_stack_card_swiper/dynamic_stack_card_swiper.dart';
import 'package:dynamic_stack_card_swiper/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'card_bloc.dart';
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
  final DynamicStackCardSwiperController<CardBloc> controller =
      DynamicStackCardSwiperController();
  final int backgroundCardCount = 3;
  bool canAddCardsSecretly = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        child: SafeArea(
          top: true,
          bottom: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .7,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 25,
                            right: 25,
                            top: 50,
                            bottom: 40,
                          ),
                          child: DynamicStackCardSwiper<CardBloc>(
                            invertAngleOnBottomDrag: true,
                            backgroundCardCount: backgroundCardCount,
                            swipeOptions: const SwipeOptions.all(),
                            controller: controller,
                            canItemBeSwiped: _canItemBeSwiped,
                            onSwipeUnauthorized: _onSwipeUnauthorized,
                            onSwipeEnd: _swipeEnd,
                            onEnd: _onEnd,
                            cardBuilder: (BuildContext context, CardBloc item) {
                              return BlocProvider.value(
                                  value: item, child: ExampleCard());
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
                Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      addItemButton(controller),
                      if (canAddCardsSecretly) addItemDownTheStack(controller),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _canItemBeSwiped(CardBloc item, AxisDirection direction) {
    return direction == AxisDirection.left || !item.isLocked;
  }

  void _onSwipeUnauthorized(CardBloc item, AxisDirection direction) {
    log('Swipe unauthorized. The card with model "${item.model.name}" cannot be swiped to : ${direction}. Swipe has been canceled.');
  }

  bool get couldAddCardsSecretlyDownTheStack =>
      (controller.items?.length ?? 0) > backgroundCardCount + 1;

  void _swipeEnd(
      CardBloc? previousModel, CardBloc? targetModel, SwiperActivity activity) {
    if (!canAddCardsSecretly && couldAddCardsSecretlyDownTheStack) {
      setState(() {
        canAddCardsSecretly = true;
      });
    } else if (canAddCardsSecretly && !couldAddCardsSecretlyDownTheStack) {
      setState(() {
        canAddCardsSecretly = false;
      });
    }
    switch (activity) {
      case Swipe():
        log('The card was swiped to the : ${activity.direction}');
        log('previous model: ${previousModel?.model.name ?? "none"}, target model: ${targetModel?.model.name ?? "none"}');
        break;
      case AddCardOnTop():
        log('A new model was added from : ${activity.direction.name}');
        log('previous model: ${previousModel?.model.name ?? "none"}, target model: ${targetModel?.model.name ?? "none"}');
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
