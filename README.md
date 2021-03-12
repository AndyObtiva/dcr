# DCR (Draw Color Repeat)

A young boy programming language for drawing and coloring with repetition.

## Programming Language Syntax

DCR always starts as a stick figure at the center of the drawing area, facing up.

Programming language commands may be entered as text with the keyboard or through the graphical user interface using the mouse.

### Turning

- `right`: Turn right by 90 degrees or any angle (e.g. `right` or `right 30`)
- `left`: Turn left by 90 degrees or any angle (e.g. `left` or `left 120`)

### Movement

- `forward`: Move foreward by one or more pixels (e.g. `forward` or `forward 50`)
- `backward`: Move backward by one or more pixels (e.g. `backward` or `backward 30`)

### Coloring

- `color`: Color the shape already drawn (closing it first) with a random or specified color from the following list (e.g. `color` or `color 'red'`):
  - 'black'
  - 'blue'
  - 'cyan'
  - 'dark_blue'
  - 'dark_cyan'
  - 'dark_gray'
  - 'dark_green'
  - 'dark_magenta'
  - 'dark_red'
  - 'dark_yellow'
  - 'gray'
  - 'green'
  - 'magenta'
  - 'red'
  - 'white'
  - 'yellow'
  
### Repetition

- `repeat`: Repeat the last operation once or a number of times (e.g. `repeat` or `repeat 5`)

## Contributing to dcr

-   Check out the latest master to make sure the feature hasn't been
    implemented or the bug hasn't been fixed yet.
-   Check out the issue tracker to make sure someone already hasn't
    requested it and/or contributed it.
-   Fork the project.
-   Start a feature/bugfix branch.
-   Commit and push until you are happy with your contribution.
-   Make sure to add tests for it. This is important so I don't break it
    in a future version unintentionally.
-   Please try not to mess with the Rakefile, version, or history. If
    you want to have your own version, or is otherwise necessary, that
    is fine, but please isolate to its own commit so I can cherry-pick
    around it.

## Copyright

Copyright (c) 2021 Andy Maleh. See [LICENSE.txt](LICENSE.txt) for further details.
