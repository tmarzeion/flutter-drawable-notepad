# Drawable Notepad

Flutter reimplementation of existing [Drawable Notepad App](https://github.com/tmarzeion/drawable-notepad)

TODO:
- Drawing history optimization (don't redraw whole history with every ui update)
- Search feature
- Translation
- Design (icons etc.)
- Tests + CI
- Architecture refactor (DI, State management, clean arch)
- Share feature

Bugs:
- Tapping without drag in draw mode should draw dots. currently it draws nothing, but still triggering undo button.