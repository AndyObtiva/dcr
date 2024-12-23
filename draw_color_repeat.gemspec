# Generated by juwelier
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Juwelier::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: draw_color_repeat 1.0.1 ruby vendor lib app

Gem::Specification.new do |s|
  s.name = "draw_color_repeat".freeze
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["vendor".freeze, "lib".freeze, "app".freeze]
  s.authors = ["Andy Maleh".freeze]
  s.date = "2024-12-11"
  s.description = "Draw Color Repeat is a young child programming language for drawing and coloring with repetition. DCR is a minimal subset of Logo.".freeze
  s.email = "andy.am@gmail.com".freeze
  s.executables = ["dcr".freeze]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    "LICENSE.txt",
    "README.md",
    "VERSION",
    "app/dcr.rb",
    "app/dcr/launch.rb",
    "app/models/dcr/command.rb",
    "app/models/dcr/command/backward.rb",
    "app/models/dcr/command/color.rb",
    "app/models/dcr/command/empty.rb",
    "app/models/dcr/command/forward.rb",
    "app/models/dcr/command/left.rb",
    "app/models/dcr/command/repeat.rb",
    "app/models/dcr/command/right.rb",
    "app/models/dcr/polygon.rb",
    "app/models/dcr/program.rb",
    "app/views/dcr/app_view.rb",
    "app/views/dcr/compass.rb",
    "bin/dcr",
    "config/warble.rb",
    "dcr.gemspec",
    "icons/linux/Dcr.png",
    "icons/macosx/Dcr.icns",
    "icons/windows/Dcr.ico",
    "lib/icon.rb",
    "package/linux/Draw Color Repeat.png",
    "package/macosx/Draw Color Repeat.icns",
    "package/windows/Draw Color Repeat.ico",
    "samples/aztec_pyramid.dcr",
    "samples/bee_hive.dcr",
    "samples/circle.dcr",
    "samples/circle_of_circles.dcr",
    "samples/envelope.dcr",
    "samples/equilateral_triangle.dcr",
    "samples/five_pointed_star.dcr",
    "samples/house.dcr",
    "samples/octagon.dcr",
    "samples/octagon_of_octagons.dcr",
    "samples/octagon_of_squares.dcr",
    "samples/playing_cards.dcr",
    "samples/rectangle.dcr",
    "samples/sherrif_badge_star.dcr",
    "samples/spider_web.dcr",
    "samples/square.dcr",
    "samples/stairs.dcr",
    "samples/stick_figure.dcr",
    "samples/sun.dcr",
    "samples/swirl.dcr",
    "samples/traffic_light.dcr",
    "samples/triangle.dcr"
  ]
  s.homepage = "http://github.com/AndyObtiva/dcr".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.3.26".freeze
  s.summary = "Draw Color Repeat".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<glimmer-dsl-swt>.freeze, ["~> 4.30.0.0"])
    s.add_runtime_dependency(%q<glimmer-cp-stickfigure>.freeze, ["~> 0.1.1"])
    s.add_runtime_dependency(%q<strategic>.freeze, ["~> 0.9.0"])
    s.add_runtime_dependency(%q<equalizer>.freeze, ["~> 0.0.11"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
    s.add_development_dependency(%q<juwelier>.freeze, ["= 2.4.9"])
    s.add_development_dependency(%q<warbler>.freeze, ["= 2.0.5"])
    s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
  else
    s.add_dependency(%q<glimmer-dsl-swt>.freeze, ["~> 4.30.0.0"])
    s.add_dependency(%q<glimmer-cp-stickfigure>.freeze, ["~> 0.1.1"])
    s.add_dependency(%q<strategic>.freeze, ["~> 0.9.0"])
    s.add_dependency(%q<equalizer>.freeze, ["~> 0.0.11"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
    s.add_dependency(%q<juwelier>.freeze, ["= 2.4.9"])
    s.add_dependency(%q<warbler>.freeze, ["= 2.0.5"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
  end
end

