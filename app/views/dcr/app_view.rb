require 'models/dcr/program'

class Dcr
  class AppView
    include Glimmer::UI::CustomShell
    
    TEXT_FONT_HEIGHT = 30
    GUI_FONT_HEIGHT = TEXT_FONT_HEIGHT - 7
    BOARD_WIDTH = 960
    BOARD_HEIGHT = 484
    
    option :program
    
    before_body {
      @command_composites = []
      self.program = Program.new(board_width: BOARD_WIDTH, board_height: BOARD_HEIGHT)
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
      
      # TODO change algorithm to only spawn widgets if none exist already, otherwise, just unbind/rebind them (or bind them with nested binding to begin with)
      observe(self, 'program.commands') do |new_commands|
        @command_composites.each(&:dispose)
        @command_composites.clear
        @command_container.content {
          new_commands.each do |new_command|
            @command_composites << composite {
              layout_data :fill, :center, true, false
              grid_layout(2, true) {
                margin_width 0
                margin_height 0
              }

              c_combo(:read_only) {
                layout_data :fill, :fill, true, true
                selection bind(new_command, :operation)
                font height: GUI_FONT_HEIGHT
              }

              if new_command.is_a?(Dcr::Command::Empty)
                label {
                  layout_data :fill, :fill, true, true
                  # just a filler as no value is needed here
                }
              elsif new_command.value.is_a?(Numeric)
                spinner {
                  layout_data :fill, :fill, true, true
                  maximum 100_000
                  selection bind(new_command, :value)
                  font height: GUI_FONT_HEIGHT
                }
              else
                text {
                  layout_data :fill, :fill, true, true
                  text bind(new_command, :value)
                  font height: GUI_FONT_HEIGHT
                }
              end
            }
          end
        }
        @old_size ||= @command_container_scrolled_composite.size
        pd @old_size.x, @old_size.y
        pd @command_container.size.x, @command_container.size.y
#         @command_container.pack(false)
        @command_container_scrolled_composite.set_min_size = Point.new(@command_container_scrolled_composite.min_width, TEXT_FONT_HEIGHT * @command_composites.size)
#         @command_container_scrolled_composite.size = @old_size
        pd @command_container_scrolled_composite.size.x, @command_container_scrolled_composite.size.y
        pd @command_container_scrolled_composite.min_width, @command_container_scrolled_composite.min_height
#         body_root.pack_same_size
      end
    }

    ## Add widget content inside custom shell body
    ## Top-most widget must be a shell or another custom shell
    #
    body {
      shell(:no_resize) {
        minimum_size BOARD_WIDTH, BOARD_HEIGHT + 316
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
              font height: TEXT_FONT_HEIGHT, name: code_text_proxy.font.font_data[0].name
              text bind(self, 'program.text')
              top_margin 0
              bottom_margin 0
            }
            composite {
              fill_layout
              @command_container_scrolled_composite = scrolled_composite {
                @command_container = composite {
                  grid_layout(1, false) {
                    margin_width 0
                    margin_height 0
                  }
                }
              }
            }
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
