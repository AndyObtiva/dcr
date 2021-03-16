require_relative 'command'
require_relative 'polygon'

class Dcr
  # A DCR program that takes text (representing commands) and board width/height for drawing polygons
  # It has a current location (x/y) and angle. Angle is clockwise, with 0 being upward (north).
  class Program
    STICK_FIGURE_SIZE = 30
    
    attr_accessor :text, :commands, :board_width, :board_height, :location_x, :location_y, :angle, :expanded_commands
    
    # array of polygon objects including array of point arrays and color to be drawn/filled in GUI
    attr_accessor :polygons
    
    def initialize(text: '', board_width: 960, board_height: 284)
      @commands = []
      @board_width = board_width
      @board_height = board_height
      @text = text
      reset!
    end
    
    def text=(value)
      reset!
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
    end
    
    def reset_location!
      # also set stick_figure_location_x and stick_figure_location_y, which is slightly different
      self.location_x = (board_width - STICK_FIGURE_SIZE) / 2.0
      self.location_y = (board_height - STICK_FIGURE_SIZE) / 2.0
    end
    
    # Resets angle (0 means upward / north). Angle value is clockwise.
    def reset_angle!
      self.angle = 0 # means pointing upward (north)
    end
    
    def reset_polygons!
      self.polygons = [Polygon.new(location_x, location_y)]
    end
    
    private
    
    def parse_commands
      self.commands = text.split("\n").map do |command_text|
        Command.create(program: self, text: command_text)
      end
    end
    
    def calculate_polygons
      reset!
      expand_commands!
      expanded_commands.each(&:call)
    end
    
    # Calls repeat commands to expand other types of commands (repeat them)
    def expand_commands!
      self.expanded_commands = commands.dup
      commands.each do |command|
        command.call if command.is_a?(Command::Repeat)
      end
    end
  end
end
