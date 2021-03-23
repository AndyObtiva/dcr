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
 
require_relative 'command'
require_relative 'polygon'

class Dcr
  # A DCR program that takes text (representing commands) and board width/height for drawing polygons
  # It has a current location (x/y) and angle. Angle is clockwise, with 0 being upward (north).
  class Program
    include Glimmer::DataBinding::ObservableModel
    
    STICK_FIGURE_SIZE = 30
    
    # the following represents the arrow showing angle direction, which is appended at the end of every execution run
    # it is represented by 7 points, either amending the last polygon if not colored, or representing a new polygon if colored
    PROGRAM_TEXT_DIRECTION_ARROW = <<~DCR
            
      f 18
      r 150
      f 4
      b 4
      l 300
      f 4
      b 4
      r 150
      b 18
      
    DCR
    
    attr_accessor :text, :commands, :canvas_width, :canvas_height, :location_x, :location_y, :angle, :expanded_commands
    
    # array of polygon objects including array of point arrays and color to be drawn/filled in GUI
    attr_accessor :polygons
    
    def initialize(text: '', canvas_width: 800, canvas_height: 600)
      @commands = []
      @canvas_width = canvas_width
      @canvas_height = canvas_height
      reset!
      self.text = text
    end
    
    def canvas_width=(new_width)
      @canvas_width = new_width
      @last_expanded_commands = nil
      calculate_polygons
    end
    
    def canvas_height=(new_height)
      @canvas_height = new_height
      @last_expanded_commands = nil
      calculate_polygons
    end
    
    def text=(value)
      @text = value
      parse_commands
    end
    
    def commands=(new_commands)
      # TODO remove observers from old commands
      @commands = new_commands
      # TODO observe commands for fine grained changes and have this update "text" as a result (which indirectly fires a "commands" change)
      calculate_polygons
    end
    
    def reset!
      reset_location!
      reset_angle!
      reset_polygons!
      reset_next_color_index!
    end
    
    def reset_location!
      # also set stick_figure_location_x and stick_figure_location_y, which is slightly different
      @last_location_x = location_x
      @last_location_y = location_y
      self.location_x = (canvas_width - STICK_FIGURE_SIZE) / 2.0
      self.location_y = (canvas_height - STICK_FIGURE_SIZE) / 2.0
    end
    
    # Resets angle (0 means upward / north). Angle value is clockwise.
    def reset_angle!
      @last_angle = angle
      self.angle = 0 # means pointing upward (north)
    end
    
    def reset_polygons!
      # reset quietly via instance variable without alerting observers with attribute writer method
      @polygons = [Polygon.new(location_x, location_y)]
    end
    
    def new_polygon!
      @polygons << Polygon.new(location_x, location_y)
    end
    
    def reset_next_color_index!
      @last_color_index = Command::Color.next_color_index
      Command::Color.reset_next_color_index!
    end
    
    private
    
    def parse_commands
      self.commands = ("#{text.strip}\n#{PROGRAM_TEXT_DIRECTION_ARROW}").split("\n").map do |command_text|
        Command.create(program: self, text: command_text)
      end
    end
    
    def calculate_polygons
      reset!
      expand_commands!
      last_expanded_commands = @last_expanded_commands
      @last_expanded_commands = expanded_commands.dup
      callable_expanded_commands = expanded_commands
      expanded_commands_without_arrow = commands_without_arrow(expanded_commands)
      expanded_commands_without_arrow_subset_matching_last_commands = expanded_commands_without_arrow && commands_without_arrow(last_expanded_commands) && expanded_commands_without_arrow[commands_without_arrow(last_expanded_commands).count..-1]
      if expanded_commands_without_arrow_subset_matching_last_commands && expanded_commands_without_arrow_subset_matching_last_commands.map(&:text) == commands_without_arrow(last_expanded_commands)&.map(&:text)
        self.location_x = @last_location_x if @last_location_x
        self.location_y = @last_location_y if @last_location_y
        self.angle = @last_angle if @last_angle
        Command::Color.reset_next_color_index!(@last_color_index)
        callable_expanded_commands = expanded_commands[commands_without_arrow(last_expanded_commands).count..-1]
        @polygons = @last_polygons
        delete_arrow!
      end
      callable_expanded_commands.each(&:call)
      @last_polygons = polygons.dup
      notify_observers(:polygons) # TODO do away with this using nested data-binding
    end
    
    # Calls repeat commands to expand other types of commands (repeat them)
    def expand_commands!
      # TODO optimize
      self.expanded_commands = commands.dup
      commands.each do |command|
        command.call if command.is_a?(Command::Repeat)
      end
      self.expanded_commands.compact!
    end
    
    def commands_without_arrow(commands)
      commands[0...-10] unless commands.nil?
    end
    
    def delete_arrow!
      @polygons.last.point_array = @polygons.last.point_array[0..-13]
    end
  end
end
