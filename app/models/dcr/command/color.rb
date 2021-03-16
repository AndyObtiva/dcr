class Dcr
  class Command
    class Color < Command
      COLORS = [
        'black',
        'blue',
        'cyan',
        'gray',
        'green',
        'magenta',
        'red',
        'white',
        'yellow',
      ]
      command_alias 'c'
      command_exclusion 'r'
      
      def call
        @program.polygons.last&.background = value
        @program.notify_observers(:polygons)
      end
      
      def value
        @value.to_s.empty? ? COLORS.sample : @value.to_s
      end
    end
  end
end
