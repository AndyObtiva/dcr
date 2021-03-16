# TODO

- Make drawing happen through the left hand of the stick figure (end of left arm)
- Process commands as case-insensitive
- Support concatenation of number to text (as tolerating error) (e.g. f3, backward9, right80)
- Consider dropping a stick figure after every forward/backward command
- draw from between the legs of the stick figure
- GUI appends command entries with a drop down for operation and a spinner/drop down for value (which could be moved up and down with drag&drop or arrows and could be deleted)
- generate GUI components in alignment with programming commands
- ability to move GUI commands
- ability to delete GUI commands
- Always keep a new GUI command hanging at the bottom
- Color `color` strings (e.g. `red`) in code_text widget
- Show an arrow in the direction the stick figure is going next
- Share drawn image by email
- Post drawn image online in the cloud along with the program for everyone to see via a link.
- Add app icon
- Consider caching of commands
- Consider caching of polygons up per command
- Consider execution delays while typing (delay to evaluate by 200ms for example)
- Save program (Save... & Save menu items with CMD+S keyboard shortcut/accelerator)
- Load program
- Undo/Redo support
- Make any command that fails to be interpreted an empty command (that way we can add comments)

## Issues

- Fix repaint issue when deleting a repeat from the end by highlighting entire repeat command line and deleting
