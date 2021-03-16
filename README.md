# DCR (Draw Color Repeat)

A young boy programming language for drawing and coloring with repetition.

DCR is a minimal subset of [Logo](https://el.media.mit.edu/logo-foundation/what_is_logo/logo_primer.html) that is intentionally simplified to teach computer programming to all 1-3 grade young boys in school (not just the ones who already gravitate towards math and computers). It uses a stick figure to draw instead of [Logo](https://el.media.mit.edu/logo-foundation/what_is_logo/logo_primer.html)'s turtle.

![Draw Color Repeat Screenshot](/images/dcr-screenshot.png)

## Programming Language Syntax

DCR always starts with a stick figure at the center of the drawing area, facing up.

Programming language commands may be entered as text with the keyboard or through the graphical user interface using the mouse.

This programming language is automatically executed while commands are being entered, so no "Run" button is needed. Boys will get to see their commands instantly drawn and alter the drawings spontaneously, thus turning this into a sort of a game too, not just a programming language.

Any invalid commands or values are simply ignored, so the programming language never errors.

If a partial command is entered (e.g. `lef` for `left` or `rig` for `right`), it is interpreted as the full command.

If an invalid value is entered (e.g. `right asdf`), the default is assumed (e.g. `90` degrees).

### Turning

- `right` (or `r`): Turn right by 90 degrees or any angle (e.g. `right`, `right 30`, or `r 30`)
- `left` (or `l`): Turn left by 90 degrees or any angle (e.g. `left`, `left 120`, or `l 120`)

### Drawing

- `forward` (or `f`): Draw in black while moving foreward by one or more pixels (e.g. `forward`, `forward 50`, or `f 50`)
- `backward` (or `b`): Draw in black while moving backward by one or more pixels (e.g. `backward`, `backward 30`, or `b 30`)

### Coloring

- `color` (or `c`): Color the shape already drawn by closing it and filling it with a random or specified color from the following list (e.g. `color`, `color red`, or `c red`):
  - `black`
  - `blue`
  - `cyan`
  - `gray`
  - `green`
  - `magenta`
  - `red`
  - `white`
  - `yellow`
  
### Repetition

- `repeat` (or `p`): Repeat all previous operations (up to the last empty line or the beginning otherwise) once or a number of times (e.g. `repeat`, `repeat 5`, or `p 5`)

## Samples

### Octagon of Squares

DCR Code:

```ruby
r
f 30
p 2
r 45
f 60
p 7
c blue
```

Screenshot:

![octagon of squares](/images/dcr-samples-octagon-of-squares.png)

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

--

[<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer/master/images/glimmer-logo-hi-res.png" height=40 />](https://github.com/AndyObtiva/glimmer) Built with [Glimmer DSL for SWT](https://github.com/AndyObtiva/glimmer-dsl-swt) (JRuby Desktop Development GUI Framework)
