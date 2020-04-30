# Drawable Notepad 2
[![Codemagic build status](https://api.codemagic.io/apps/5e9ea4ef23fafc18149bd52a/5e9ea4ef23fafc18149bd529/status_badge.svg)](https://codemagic.io/apps/5e9ea4ef23fafc18149bd52a/5e9ea4ef23fafc18149bd529/latest_build)


Flutter reimplementation of existing [Drawable Notepad App](https://github.com/tmarzeion/drawable-notepad)

Features:
- Rich-text editor
- Drawing on notes
- Saving/Updating/Removing notes
- Saving notes on-fly
- Draw mode setting bar state persistance
- Saved setting of draw/text modes
- Long press on note item -> Modal preview
- Share feature
- Supported languages: English, Polish, Danish, German, Russian, French, Japanese, Spanish
- Interactive intro screen

TODO:
- Search feature
- Tests + CI
- Architecture refactor (DI, State management, clean arch)

Bugs:

Some widgets shouldn't appear:
1. Search query for no results
2. Cancel search mode
3. See if there are blinking widgets