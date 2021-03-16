require 'models/dcr/program'

require_relative 'stick_figure'
  
class Dcr
  class AppView
    include Glimmer::UI::CustomShell
    
    option :program

    before_body {
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
      observe(self, 'program.polygons') { |new_polygons|
        # TODO consider disposing canvas shapes instead of the canvas itself (for perhaps improved performance)
        @canvas.shapes.reject { |shape| shape.class == Glimmer::SWT::Custom::Shape }.each(&:dispose)
        new_polygons.each { |new_polygon|
          @canvas.content {
            polygon(new_polygon.point_array) {
              if new_polygon.background.nil?
                foreground :black
              else
                background new_polygon.background
              end
            }
          }
        }
      }
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
              text bind(self, 'program.text')
            }
            @program_composite = composite
          }
          @canvas_container = scrolled_composite(:none) {
            @canvas = canvas {
              background :white
              
              # TODO show arrow pointing in the right direction (based on program.angle)
              @stick_figure = stick_figure(
                size: Program::STICK_FIGURE_SIZE,
              ) {
                location_x bind(self, 'program.location_x')
                location_y bind(self, 'program.location_y')
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
