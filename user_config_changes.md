# Changes
The following contains the list of the changes that my setup makes to the default GIMP configuration. The list may be incomplete:

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
- Added shortcut for switching the image into RGB mode - `1`
- Added shortcut for switching the image into indexed mode - `2`
- Added shortcut for switching the image into graycasle mode - `3`
- Added shortcut for adding a new layer mask `l`
- Added shortcut for applying the layer mask `;`
- Added shortcuts for toggling different layer mask settings `,`, `.` and `'`
- Removed "Strong Undo" and "Strong Redo" shortcuts.
- Replaced the "Redo" shortcut with `Ctrl+Shift+Z` instead of `Ctrl+Y`.
- Added file override shortcut `Shift+Alt+S`
- Added shortcut for changing the grid settings `Shift+Alt+G`
- Added shortcut for toggling the grid visibility `Alt+G`
- Added shortcut for "Layer To Image Size" function `Alt+Q`. This makes it easier to work with layers when, by default, in GIMP, almost always you end up with a layer that has a weird yellow border around it or outside of the image bounds.
- Changed some of the default shortcuts. See list below.

# Shortcut summary
The following is a list of the shortcuts groupped by their categories.

## Basic Tools
Basic tools don't have a modifier key.
Pencil: `N` ==> `P` (since paintbrush has bee unbound)
Gradient: `G`
Bucket Fill: `Shift + B` ==> `B`
Clone: `C`
Warp: `W`
Eraser: `Shift + E` ==> `E`
Text: `T`
Align: `Q` ==> `A`

## Transform Tools
Transform tools also don't have a modifier key.
Rotate: `Shift + R` ==> `R`
Scale: `Shift + S` ==> `S`
Move: `M`
Flip: `Shift + F` ==> `F`

## Selection Tools
Selection tools always start with `Shift`.
Rectangle: `R` ==> `Shift + R`
Ellipse: `E` ==> `Shift + E`
Fuzzy Select: `U` ===> `Shift + W` (wand)
Free Select: `F` ===> `Shift + L` (lassso)
Select by Color: `Shift + O` ===> `Shift + C`

## Other
Revert: `F12`
Layer to image size: `Alt+Q`
Crop to Selection: `Ctrl + Shift + X` (like in MS paint and probably other programs)

## Layer
Layer mask management shortcuts are on the right side of the keyboard.
Add Layer Mask: `L`
Apply Layer Mask: `;`
Edit Layer Mask (toggle): `,`
Show Layer Mask (toggle): `
Disable Layer Mask (toggle): `.`


## Grid management
Grid always start with `Alt`
Grid settings: `Shift+Alt+G`
Toggle grid visibility: `Alt+G`

## Image Color Modes
Mode - RGB: `1`
Mode - Indexed: `2`
Mode - Grayscale: `3`