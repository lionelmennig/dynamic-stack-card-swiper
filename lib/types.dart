import 'package:flutter/material.dart';

import 'enums.dart';

typedef OnSwipe<T> = void Function(
    T? previousItem,
    T? targetItem,
    SwiperActivity activity,
);

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);