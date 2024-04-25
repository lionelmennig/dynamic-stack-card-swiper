## [1.3.0] - 2024.04.25

* Implements a way to disallow swipes in some direction(s) for a given item (canItemBeSwiped)
* Animates card back to its initial location and triggers a callback whenever it occurs (onSwipeUnauthorized)
* Removes isItemLocked property
* Fixes onTapDisabled callback not being called like it should

## [1.2.0] - 2024.04.24

* Exposes the current stack in the controller

## [1.1.0] - 2024.04.24

* Implements isItemLocked to have a way to prevent a specific card from being swiped (in any way)

## [1.0.1] - 2024.04.24

* Fixes targetIndex setting, previously returning the wrong target onSwipeBegin and onSwipeEnd

## [1.0.0] - 2024.04.23

* Initial version