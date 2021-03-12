require_relative 'stick_figure'
  
class Dcr
  class AppView
    include Glimmer::UI::CustomShell
    
    ## Add options like the following to configure CustomShell by outside consumers
    #
    # options :title, :background_color
    # option :width, default: 320
    # option :height, default: 240
    option :greeting, default: 'Hello, World!'

    ## Use before_body block to pre-initialize variables to use in body
    #
    #
    before_body {
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

    ## Use after_body block to setup observers for widgets in body
    #
    # after_body {
    #
    # }

    ## Add widget content inside custom shell body
    ## Top-most widget must be a shell or another custom shell
    #
    body {
      shell {
        minimum_size 320, 240
        image File.join(APP_ROOT, 'package', 'windows', "Dcr.ico") #if OS.windows?
        text "Draw Color Repeat"
        
        on_swt_show {
          unless @shown
            body_root.bounds = display.bounds
            @stick_figure.move_by(@canvas.bounds.width / 2, @canvas.bounds.height / 2,)
            @shown = true
          end
        }
        
        sash_form(:vertical) {
          sash_form {
            @commands_text = code_text(lines: true) { |code_text_proxy|
              font height: 40, name: code_text_proxy.font.font_data[0].name
            }
            @commands_composite = composite
          }
          scrolled_composite {
            @canvas = canvas { |canvas_proxy|
              background :white
              
              @stick_figure = stick_figure(
                x: canvas_proxy.bounds.width / 2,
                y: canvas_proxy.bounds.height / 2,
                width: 30,
                height: 30,
              )
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
#             menu_item {
#               text '&Preferences...'
#               on_widget_selected {
#                 display_preferences_dialog
#               }
#             }
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
    
#     def display_preferences_dialog
#       dialog(swt_widget) {
#         text 'Preferences'
#         grid_layout {
#           margin_height 5
#           margin_width 5
#         }
#         group {
#           row_layout {
#             type :vertical
#             spacing 10
#           }
#           text 'Greeting'
#           font style: :bold
#           [
#             'Hello, World!',
#             'Howdy, Partner!'
#           ].each do |greeting_text|
#             button(:radio) {
#               text greeting_text
#               selection bind(self, :greeting) { |g| g == greeting_text }
#               layout_data {
#                 width 160
#               }
#               on_widget_selected { |event|
#                 self.greeting = event.widget.getText
#               }
#             }
#           end
#         }
#       }.open
#     end

  end
  
end
