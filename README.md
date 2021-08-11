# <img alt="DCR" src="https://raw.githubusercontent.com/AndyObtiva/dcr/master/package/linux/Draw%20Color%20Repeat.png" height=85 /> DCR (Draw Color Repeat) 1.0.0
[![Gem Version](https://badge.fury.io/rb/dcr.svg)](http://badge.fury.io/rb/dcr)
​

A young child programming language for drawing and coloring with repetition.

DCR is a minimal subset of [Logo](https://el.media.mit.edu/logo-foundation/what_is_logo/logo_primer.html) that is intentionally simplified to teach computer programming to all 1-3 grade young children in school (not just the ones who already gravitate towards math and computers). It uses a stick figure to draw instead of [Logo](https://el.media.mit.edu/logo-foundation/what_is_logo/logo_primer.html)'s turtle.

![Draw Color Repeat Screenshot](/images/dcr-screenshot.png)

[<img alt="DCR" src="https://raw.githubusercontent.com/AndyObtiva/dcr/master/package/linux/Draw%20Color%20Repeat.png" height=40 /> Download version 1.0.0 for the Mac (x64 Big Sur and older)](https://www.dropbox.com/s/uuu05kzg0grhune/Draw%20Color%20Repeat-1.0.0.dmg?dl=1)

## Programming Language Syntax

DCR always starts with a stick figure at the center of the drawing area, facing up.

![Draw Color Repeat Start](/images/dcr-start.png)

Programming language commands may be entered as text with the keyboard or through the graphical user interface using the mouse.

This programming language is automatically executed while commands are being entered, so no "Run" button is needed. Chilren will get to see their commands instantly drawn and alter the drawings spontaneously, thus turning this into a sort of a game too, not just a programming language.

Any invalid commands or values are simply ignored, so the programming language never errors.

If a partial command is entered (e.g. `lef` for `left` or `rig` for `right`), it is interpreted as the full command.

If a partial color value is entered (e.g. `gree` for `green` or `rd` for `red`), it is interpreted as the full color value.

If an invalid value is entered (e.g. `right asdf`), the default is assumed (e.g. `90` degrees).

### Turning

- `right` (or `r`): Turn right by 90 degrees or any angle (e.g. `right`, `right 30`, or `r 30`)
- `left` (or `l`): Turn left by 90 degrees or any angle (e.g. `left`, `left 120`, or `l 120`)

### Drawing

- `forward` (or `f`): Draw in black while moving foreward by one or more pixels (e.g. `forward`, `forward 50`, or `f 50`)
- `backward` (or `b`): Draw in black while moving backward by one or more pixels (e.g. `backward`, `backward 30`, or `b 30`)

### Coloring

- `color` (or `c`): Color the shape already drawn by closing it and filling it with a random or specified color from the following list (e.g. `color`, `color red`, or `c red`):
  - `black` (or `k`)
  - `blue` (or `b`)
  - `gray` (or `a`)
  - `green` (or `g`)
  - `orange` (or `o`)
  - `pink` (or `i`)
  - `purple` (or `p`)
  - `red` (or `r`)
  - `white` (or `w`)
  - `yellow` (or `y`)
  
### Repetition

- `repeat` (or `p`): Repeat all previous operations (up to the last empty line or the beginning otherwise) once or a number of times (e.g. `repeat`, `repeat 5`, or `p 5`)

## Samples

### Rectangle

DCR Code:

```ruby
forward 80
right
forward 160
right
repeat
color green
```

Screenshot:

![rectangle](/images/dcr-samples-rectangle.png)

### Square

DCR Code:

```ruby
forward 80
right
repeat 3
color yellow
```

Screenshot:

![square](/images/dcr-samples-square.png)

### Triangle

DCR Code:

```ruby
right 60
forward 180
right 80
forward 270
color black
```

Screenshot:

![triangle](/images/dcr-samples-triangle.png)

### Equilateral Triangle

DCR Code:

```ruby
left

forward 100
right 120
repeat 2
color blue
```

Screenshot:

![equilateral triangle](/images/dcr-samples-equilateral-triangle.png)

### Octagon

DCR Code:

```ruby
right 45
forward 80
repeat 7
color red
```

Screenshot:

![octagon](/images/dcr-samples-octagon.png)

### Circle

DCR Code:

```ruby
forward
right 1
repeat 360
color orange
```

Screenshot:

![circle](/images/dcr-samples-circle.png)

### Envelope

DCR Code:

```ruby
left 60
forward 104
right 150
forward 180
right 150
forward 104
backward 104
left 60
forward 90
right
forward 180
right
forward 90
color white
```

Screenshot:

![envelope](/images/dcr-samples-envelope.png)

### Bee Hive

DCR Code:

```ruby
right 60
forward 20
repeat 4
color yellow
left 60
forward 20
repeat 2
right 60
forward 20
repeat 4
right 60
forward 20
left 60
forward 20
repeat 5
```

Screenshot:

![bee hive](/images/dcr-samples-bee-hive.png)

### Five Pointed Star

DCR Code:

```ruby
left 144
forward 140
repeat 4
color white
```

Screenshot:

![five pointed star](/images/dcr-samples-five-pointed-star.png)

### Sherrif Badge Star

DCR Code:

```ruby
right 37

forward 28
right 51
forward 28
left 102
repeat 6
color yellow
```

Screenshot:

![sherrif badge star](/images/dcr-samples-sherrif-badge-star.png)

### Stairs

DCR Code:

```ruby
forward 20
right
forward 20
left
repeat 5
backward 240
left
forward 240
right

forward 20
right
forward 20
left
repeat 5
color white
```

Screenshot:

![stairs](/images/dcr-samples-stairs.png)

### Aztec Pyramid

DCR Code:

```ruby
right
forward 20
left
forward 20
repeat 5
right
forward 20

right
forward 20
left
forward 20
repeat 5
color yellow
```

Screenshot:

![aztec pyramid](/images/dcr-samples-aztec-pyramid.png)

### Stick Figure

DCR Code:

```ruby
right 65
forward 70
backward 70
left 130
forward 70
backward 70
right 65
forward 30
right

left 4
forward 1
repeat 90

right 94
forward 80
right 55
forward 90
backward 90
left 110
forward 90
```

Screenshot:

![stick figure](/images/dcr-samples-stick-figure.png)


### Octagon of Squares

DCR Code:

```ruby
right
forward 30
repeat 2
right 45
forward 60
repeat 7
color blue
```

Screenshot:

![octagon of squares](/images/dcr-samples-octagon-of-squares.png)

### Octagon of Octagons

DCR Code:

```ruby
forward 20
right 45
repeat 6
color
forward 70
repeat 9
```

Screenshot:

![octagon of octagons](/images/dcr-samples-octagon-of-octagons.png)

### Circle of Circles

DCR Code:

```ruby
right 8
forward 2
repeat 45
color
right 10
forward 32
repeat 19
```

Screenshot:

![circle of circles](/images/dcr-samples-circle-of-circles.png)

### Spider Web

DCR Code:

```ruby
right 10
forward 180
repeat 35
right 110
forward 260
repeat 35
```

Screenshot:

![house](/images/dcr-samples-spider-web.png)

### Swirl

DCR Code:

```ruby
forward 200
right 45
repeat 6
color
forward 200
right 38
repeat 51
```

Screenshot:

![swirl](/images/dcr-samples-swirl.png)

### Sun

DCR Code:

```ruby
back 450

forward 150
right 5
repeat
color yellow
back 300
left 5
repeat 180
```

Screenshot:

![sun](/images/dcr-samples-sun.png)

### Playing Cards

DCR Code:

```ruby
forward 50
right
forward 36
right
repeat
color
left 9
forward 5
repeat 14
```

Screenshot:

![playing cards](/images/dcr-samples-playing-cards.png)

### Traffic Light

DCR Code:

```ruby
backward 40

forward
right 2
repeat 180
color green

left 2
forward 60

forward
right 2
repeat 180
color yellow

left 2
forward 60

forward
right 2
repeat 180
color red

forward
right 2
repeat 90

left 4
forward 120
```

Screenshot:

![traffic light](/images/dcr-samples-traffic-light.png)

### House

DCR Code:

```ruby
right 45
forward 80
right
forward 80
right 135
forward 113
color red
right

right
forward 113
right
forward 113
right
forward 74
right
forward 40
right
forward 30
right
forward 40
right
forward 70
right
color gray
```

Screenshot:

![house](/images/dcr-samples-house.png)

## Ruby gem

The [dcr](https://rubygems.org/gems/dcr) ruby gem requires the [JDK](https://www.oracle.com/ca-en/java/technologies/javase-downloads.html) and [JRuby](https://www.jruby.org) versions mentioned in the pre-requisites of [Glimmer DSL for SWT](https://github.com/AndyObtiva/glimmer-dsl-swt#pre-requisites) to run.

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
