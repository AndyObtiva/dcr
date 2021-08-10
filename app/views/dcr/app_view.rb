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
    
    option :program
    
    before_body {
      @command_composites = []
      self.program = Program.new(board_width: 960, board_height: 284)
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
      # TODO implement commands GUI
#       observe(self, 'program.commands') do |new_commands|
#         pd new_commands
#         @command_composites.each(&:dispose)
#         @program_composite.content {
#           new_commands.each do |new_command|
#             @command_composites << composite {
#               row_layout
#
#               combo(:read_only) {
#                 selection bind(new_command, :operation)
#               }
#
#               text {
#                 text bind(new_command, :value)
#               }
#             }
#           end
#         }
#       end
      observe(self, 'program.polygons') do |new_polygons|
        if new_polygons != @last_polygons
          @polygon_container.shapes.dup.each(&:dispose)
          @polygon_container.content {
            new_polygons.each do |new_polygon|
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
            end
          }
          @last_polygons = new_polygons
        end
      end
    }

    ## Add widget content inside custom shell body
    ## Top-most widget must be a shell or another custom shell
    #
    body {
      shell(:no_resize) {
        minimum_size 960, 600
#         image File.join(APP_ROOT, 'package', 'windows', "Dcr.ico") #if OS.windows?
        # TODO save this image to a file for packaging use
        image(512, 512) {
          rectangle(0, 0, :max, :max) {
            background :white
          }
          stick_figure(
                location_x: 0,
                location_y: 50,
                size: 425,
              ) {
            line_width 10
            foreground :black
          }
        }
        text "Draw Color Repeat"
        
        sash_form(:vertical) {
          sash_form {
            @program_text = code_text(lines: true) { |code_text_proxy|
              font height: 30, name: code_text_proxy.font.font_data[0].name
              text <=> [self, 'program.text']
            }
            @program_composite = composite
          }
          @canvas_container = scrolled_composite(:none) {
            @canvas = canvas {
              background :white
           
              # This is where drawn shapes are added
              @polygon_container = shape(0, 0, :max, :max)
              
              # TODO show arrow pointing in the right direction (based on program.angle)
              @stick_figure = stick_figure(
                size: Program::STICK_FIGURE_SIZE,
              ) {
                location_x <= [self, 'program.location_x', on_read: ->(x) { x - 6 }]
                location_y <= [self, 'program.location_y', on_read: ->(y) { y - 6 }]
              }
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
        message "Draw Color Repeat #{VERSION}\n\n#{LICENSE}"
      }.open
    end
  
  end
  
end
