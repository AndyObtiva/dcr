# TODO

## Releases

### 1.0.0

- Adjust layout given we do not have a command GUI in this version (put drawing to the right of the commands)
- Make drawing happen through the left hand of the stick figure (end of left arm)
- Show an arrow in the direction the stick figure is going next
- Process commands as case-insensitive
- Have single letter acronyms for colors
- Save program (Save... & Save menu items with CMD+S keyboard shortcut/accelerator)
- Load program (start at samples path)
- Extract samples from jar in packaged app run
- Optimize performance for high repetition counts or show a dialog saying "redrawing" if redrawing takes too long (longer than 5 seconds) with a cancel button
- Consider drawing async
- Ensure there are 24 samples total (implement 4 more samples that fill the screen mostly with one filling it entirely)

### TBD

- GUI appends command entries with a drop down for operation and a spinner/drop down for value (which could be moved up and down with drag&drop or arrows and could be deleted)
- generate GUI components in alignment with programming commands
- ability to move GUI commands
- ability to delete GUI commands
- Always keep a new GUI command hanging at the bottom
- Color `color` strings (e.g. `red`) in code_text widget
- Share drawn image by email
- Post drawn image online in the cloud along with the program for everyone to see via a link.
- Consider caching of commands
- Consider caching of polygons up per command
- Undo/Redo support
- Make any command that fails to be interpreted an empty command (that way we can add comments)
- Extract string fuzz matching algorithm into its own Ruby gem
- Consider delaying execution by a 200 milliseconds while typing
- Avoid re-duplicating polygons that already exist (thus optimizing performance)
- Support easy listing/loading of included samples

## Issues

- Look into issue of typing an invalid command in a series of many commands undoing previous drawings from previous commands
