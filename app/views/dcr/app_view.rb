require 'models/dcr/program'

require 'views/dcr/compass'

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
      shell(:fill_screen, :no_resize) {
        minimum_size DEFAULT_CANVAS_WIDTH, DEFAULT_CANVAS_HEIGHT + 316
        image File.join(APP_ROOT, 'package', 'windows', "Draw Color Repeat.ico")
        text "Draw Color Repeat"
        
        sash_form(:horizontal) {
          weights 2, 4
          sash_width 10
        
          @program_text = code_text(lines: true) { |code_text_proxy|
            font height: TEXT_FONT_HEIGHT, name: code_text_proxy.font.font_data[0].name
            text <=> [self, 'program.text']
            top_margin 0
            bottom_margin 0
          }

          @canvas_container = scrolled_composite(:none) {
            @canvas = canvas {
              background :white
              
              on_control_resized {
                program.canvas_width = @canvas.bounds.width
                program.canvas_height = @canvas.bounds.height
              }
              
           
              # This is where drawn shapes are added
              @polygon_container = shape(0, 0, :max, :max)
              
              # TODO show arrow pointing in the right direction (based on program.angle)
              @stick_figure = stick_figure(
                size: Program::STICK_FIGURE_SIZE,
              ) {
                location_x <= [self, 'program.location_x', on_read: ->(x) {x - 6}]
                location_y <= [self, 'program.location_y', on_read: ->(y) {y - 6}]
              }
              
              @compass = compass {
                location_x <= [self, 'program.location_x']
                location_y <= [self, 'program.location_y']
                angle <= [self, 'program.angle']
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
        message "The DCR Programming Language (Draw Color Repeat) #{VERSION}\n\n#{LICENSE}"
      }.open
    end
  end
  
end
