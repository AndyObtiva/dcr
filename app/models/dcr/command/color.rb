class Dcr
  class Command
    class Color < Command
      # color map from strings to Glimmer DSL for SWT colors
      COLOR_MAP = {
        'black' => :black,
        'blue' => :cyan,
        'gray' => :gray,
        'grey' => :gray,
        'green' => :green,
        'orange' => [255, 127, 0],
        'pink' => :magenta,
        'purple' => :dark_magenta,
        'red' => :red,
        'white' => :white,
        'yellow' => :yellow,
      }
      command_alias 'c'
      command_exclusion 'r'
      
      class << self
        def expanded_color_map
          @expanded_color_map = COLOR_MAP.reduce({}) do |hash, pair|
            color_string = pair.first
            color_value = pair.last
            color_hash = color_derivatives(color_string).reduce({}) do |color_derivative_hash, color_derivative|
              color_derivative_hash.merge(color_derivative => color_value)
            end
            hash.merge(color_hash)
          end
        end
        
        def color_derivatives(color_string)
          color_string_length = color_string.length
          color_string_length.times.map {|n| color_string.chars.combination(color_string_length - n).to_a}.reduce(:+).map(&:join)
        end
      
        def next_color
          @next_color_index = @next_color_index.nil? ? 0 : @next_color_index + 1
          unique_colors[@next_color_index % unique_colors.count]
        end
        
        def unique_colors
          @unique_colors ||= COLOR_MAP.values.uniq
        end
      end
      
      def call
        @program.polygons.last&.background = value
        @program.new_polygon!
      end
      
      def value
        !Color.expanded_color_map.keys.include?(super.to_s) ? Color.next_color : Color.expanded_color_map[super.to_s]
      end
    end
  end
end
