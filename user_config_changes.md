This file contains the list of the changes that my setup makes to the default GIMP configuration. The list may be incomplete:

- Removed a lot of the tools from the toolbox and removed their shortcuts. The toolbox now contains only the following tools:
    - Pencil Tool
    - Eraser Tool
    - Clone Tool
    - Warp Tool
    - Bucket Fill Tool
    - Gradient Tool
    - Text Tool
    - Move Tool
    - Rectangle Select Tool
    - Ellipse Select Tool
    - Free Select Tool
    - Fuzzy Select Tool
    - Select by Color Tool
    - Alignment Tool
    - Rotate Tool
    - Scale Tool
    - Flip Tool
    - Some of the tools at the bottom of the toolbox are grouped in folders together.
- Removed shortcuts for increasing/decreasing opacity of the brush.
- Removed all zoom ratio shortcuts (Ctrl+1, Ctrl+2, etc). To free them for other uses.
- Removed shortcut to open the brushes menu.
- Removed image properties viewer shortcut.
- Added crop to selection shortcut `Ctrl+Shift+X`
- Added shortcut for reverting the image `F12`. This is useful when working with another program that modifies the image file so you can quickly reload it from disk.
- Added shortcut for switching the image into RGB mode - `Numpad /`
- Added shortcut for switching the image into indexed mode - `Numpad *`
- Added shortcut for adding a new layer mask `l`
- Added shortcut for applying the layer mask `;`
- Added shortcuts for toggling different layer mask settings `,`, `.` and `'`
- Removed "Strong Undo" and "Strong Redo" shortcuts.
- Replaced the "Redo" shortcut with `Ctrl+Shift+Z` instead of `Ctrl+Y`.
- Added file override shortcut `Shift+Alt+S`
- Added shortcut for changing the grid settings `Ctrl+Shift+Alt+G`
- Added shortcut for toggling the grid visibility `Ctrl+Shift+G`
- Added shortcut for "Layer To Image Size" function `Alt+Q`. This makes it easier to work with layers when, by default, in GIMP, almost always you end up with a layer that has a weird yellow border around it or outside of the image bounds.


The new shortcuts currently don't collide with any of the defaults ones, however, since I removed a lot of the default shortcuts I will probably change the complicated custom shortcuts to something simpler in the future. 
