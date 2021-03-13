require_relative 'command'
  
class Dcr
  class Program
    attr_reader :text, :commands
    
    def initialize(text = '')
      @commands = []
      self.text = text
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
    
    # array of polygon objects including array of point arrays and color to be drawn/filled in GUI
    def polygons
    end
    
    private
    
    def parse_commands
      self.commands = text.split("\n").map do |command_text|
        Command.create(program: self, text: command_text)
      end
    end
    
    def calculate_polygons
    end
  end
end
