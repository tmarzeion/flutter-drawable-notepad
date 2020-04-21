# Drawable Notepad


Flutter reimplementation of existing [Drawable Notepad App](https://github.com/tmarzeion/drawable-notepad)

[Sample movie](https://youtu.be/QLOBKFAdMm8)

TODO:
- Drawing history optimization (don't redraw whole history with every ui update)
- Search feature
- Translation
- Design (icons etc.)
- Tests + CI
- Architecture refactor (DI, State management, clean arch)
- Share feature
- Note updating on fly

Bugs:
- Tapping without drag in draw mode should draw dots. currently it draws nothing, but still triggering undo button.
