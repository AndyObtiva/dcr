# TODO

- Make drawing happen through the left hand of the stick figure (end of left arm)
- Process commands as case-insensitive
- Support concatenation of number to text (as tolerating error) (e.g. f3, backward9, right80)
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
- Save program (Save... & Save menu items with CMD+S keyboard shortcut/accelerator)
- Load program (start at samples path)
- Undo/Redo support
- Make any command that fails to be interpreted an empty command (that way we can add comments)
- Extract string fuzz matching algorithm into its own Ruby gem
- Extract samples from jar in packaged app run

## Issues

- Look into issue of typing an invalid command in a series of many commands undoing previous drawings from previous commands
