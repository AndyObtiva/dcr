# Copyright (c) 2021 Andy Maleh
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
require 'models/dcr/program'

class Dcr
  class AppView
    include Glimmer::UI::CustomShell
    
    TEXT_FONT_HEIGHT = 30
    GUI_FONT_HEIGHT = TEXT_FONT_HEIGHT - 7
    DEFAULT_CANVAS_WIDTH = 960
    DEFAULT_CANVAS_HEIGHT = 464
    
    option :program
    
    before_body {
      @command_composites = []
      self.program = Program.new(canvas_width: DEFAULT_CANVAS_WIDTH, canvas_height: DEFAULT_CANVAS_HEIGHT)
      Display.app_name = 'Draw Color Repeat'
      Display.app_version = VERSION
      @display = display {
        on_about {
          display_about_dialog
        }
        on_preferences {
          display_about_dialog
        }
      }
    }
    
    after_body {
      observe(self, 'program.polygons') do |new_polygons|
        if new_polygons != @last_polygons
          @last_polygons = new_polygons
          program_location_x = program.location_x
          program_location_y = program.location_y
          async_exec {
            @polygon_container.shapes.dup.each {|shape| shape.dispose(redraw: @polygon_container.shapes.count == 1)} unless new_polygons != @last_polygons
          }
          new_polygons.each_with_index { |new_polygon, polygon_index|
            unless new_polygons.count == 1 || polygon_index == (new_polygons.count - 1)
              (new_polygon.point_array.count / 2).times {|point_index|
                async_exec {
                  program.location_x = new_polygon.point_array[point_index*2] unless new_polygons != @last_polygons
                }
                async_exec {
                  program.location_y = new_polygon.point_array[point_index*2 + 1] unless new_polygons != @last_polygons
                }
              }
            end
            async_exec {
              unless new_polygons != @last_polygons
                @polygon_container.content {
                  if new_polygon.background.nil?
                    polyline(new_polygon.point_array) {
                      foreground :black
                    }
                  else
                    polygon(new_polygon.point_array) {
                      background new_polygon.background
                    }
                    polygon(new_polygon.point_array) {
                      foreground :black
                    }
                  end
                }
              end
            }
          }
          async_exec {
            program.location_x = program_location_x unless new_polygons != @last_polygons
          }
          async_exec {
            program.location_y = program_location_y unless new_polygons != @last_polygons
          }
        end
      end
      
      # TODO implement command GUI in version 1.1+
      # TODO change algorithm to only spawn widgets if none exist already, otherwise, just unbind/rebind them (or bind them with nested binding to begin with)
#       observe(self, 'program.commands') do |new_commands|
#         @command_composites.each(&:dispose)
#         @command_composites.clear
#         @command_container.content {
#           new_commands.each do |new_command|
#             @command_composites << composite {
#               layout_data :fill, :center, true, false
#               grid_layout(2, true) {
#                 margin_width 0
#                 margin_height 0
#               }
#
#               c_combo(:read_only) {
#                 layout_data :fill, :fill, true, true
#                 selection bind(new_command, :operation)
#                 font height: GUI_FONT_HEIGHT
#               }
#
#               if new_command.is_a?(Dcr::Command::Empty)
#                 label {
#                   layout_data :fill, :fill, true, true
#                   ### just a filler as no value is needed here
#                 }
#               elsif new_command.value.is_a?(Numeric)
#                 spinner {
#                   layout_data :fill, :fill, true, true
#                   maximum 100_000
#                   selection bind(new_command, :value)
#                   font height: GUI_FONT_HEIGHT
#                 }
#               else
#                 text {
#                   layout_data :fill, :fill, true, true
#                   text bind(new_command, :value)
#                   font height: GUI_FONT_HEIGHT
#                 }
#               end
#             }
#           end
#         }
#         @old_size ||= @command_container_scrolled_composite.size
#         pd @old_size.x, @old_size.y
#         pd @command_container.size.x, @command_container.size.y
#         @command_container.pack(false)
#         @command_container_scrolled_composite.set_min_size = Point.new(@command_container_scrolled_composite.min_width, TEXT_FONT_HEIGHT * @command_composites.size)
#         @command_container_scrolled_composite.size = @old_size
#         pd @command_container_scrolled_composite.size.x, @command_container_scrolled_composite.size.y
#         pd @command_container_scrolled_composite.min_width, @command_container_scrolled_composite.min_height
#         body_root.pack_same_size
#       end
    }

    ## Add widget content inside custom shell body
    ## Top-most widget must be a shell or another custom shell
    #
    body {
      shell {
        minimum_size DEFAULT_CANVAS_WIDTH, DEFAULT_CANVAS_HEIGHT + 316
        image File.join(APP_ROOT, 'package', 'windows', "Draw Color Repeat.ico")
        text "Draw Color Repeat"
        
        on_swt_show {
          if @body_root_shown.nil?
            @body_root_shown = true
            body_root.bounds = display.bounds
          end
        }
        
        sash_form(:horizontal) {
          weights 2, 4
          sash_width 10
          background rgb(230, 230, 230)
          
          # TODO enable for version 1.1+
#           @command_scrolled_composite = scrolled_composite {
#             sash_form {
#               sash_width 10
#               background rgb(230, 230, 230)
              
          @program_text = code_text(lines: true) { |code_text_proxy|
            font height: TEXT_FONT_HEIGHT, name: code_text_proxy.font.font_data[0].name
            text bind(self, 'program.text')
            top_margin 0
            bottom_margin 0
          }
          # TODO enable for version 1.1+
#               composite {
#                 fill_layout
#
#                 @command_container = composite {
#                   grid_layout(1, false) {
#                     margin_width 0
#                     margin_height 0
#                   }
#                 }
#               }
#             }
#           }
          @canvas_container = scrolled_composite(:none) {
            @canvas = canvas {
              background :white
              
              on_control_resized {
                program.canvas_width = @canvas.bounds.width
                program.canvas_height = @canvas.bounds.height
              }
           
              # This is where drawn shapes are added
              @polygon_container = shape(0, 0, :max, :max)
              
              @stick_figure = stick_figure(
                size: Program::STICK_FIGURE_SIZE,
              ) {
                # translate coordinate values in converters to touch the drawing point with the hand of the stick figure
                location_x bind(self, 'program.location_x', read_only: true) {|value| value - 6}
                location_y bind(self, 'program.location_y', read_only: true) {|value| value - 6}
              }
              
#               @compass = shape {
#                 x bind(self, 'program.location_x') {|value| value - 10 }
#                 y bind(self, 'program.location_y') {|value| value - 16}
#                 transform {
#                   rotate bind(self, 'program.angle')
#                 }
#
#                 line(10, 0, 10, 18)
#                 line(10, 0, 6, 6)
#                 line(10, 0, 14, 6)
#               }
            }
          }
        }
                
        menu_bar {
          menu {
            text '&File'
            menu_item {
              text '&About...'
              on_widget_selected {
                display_about_dialog
              }
            }
          }
        }
      }
    }

    def display_about_dialog
      message_box(body_root) {
        text 'About'
        message "The DCR Programming Language (Draw Color Repeat) #{VERSION}\n\n#{LICENSE}"
      }.open
    end
  
  end
  
end
