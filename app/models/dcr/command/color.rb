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
      COLOR_MAP_ALIASES = {
        'grey' => :gray,
        'k' => :black,
        'b' => :cyan,
        'a' => :gray,
        'g' => :green,
        'o' => [255, 127, 0],
        'i' => :magenta,
        'p' => :dark_magenta,
        'r' => :red,
        'w' => :white,
        'y' => :yellow,
      }
      command_alias 'c'
      command_exclusion 'r'
      
      class << self
        attr_reader :next_color_index
        
        def expanded_color_map
          @expanded_color_map ||= COLOR_MAP.reduce({}) do |hash, pair|
            color_string = pair.first
            color_value = pair.last
            color_hash = color_derivatives(color_string).reduce({}) do |color_derivative_hash, color_derivative|
              color_derivative_hash.merge(color_derivative => color_value)
            end
            hash.merge(color_hash)
          end.merge(COLOR_MAP_ALIASES)
        end
        
        def color_derivatives(color_string)
          color_string_length = color_string.length
          color_string_length.times.map {|n| color_string.chars.combination(color_string_length - n).to_a}.reduce(:+).map(&:join)
        end
      
        def next_color_string
          reset_next_color_index! if @next_color_index.nil?
          @next_color_index += 1
          COLOR_MAP.keys[@next_color_index % COLOR_MAP.count]
        end
              
        def next_color
          COLOR_MAP[next_color_string]
        end
        
        def reset_next_color_index!(next_color_index_value=nil)
          @next_color_index = next_color_index_value || -2 # start at yellow (since it skips one with the first addition)
        end
        
        def normalize_color_string(color_string)
          color_value = Color.expanded_color_map[color_string]
          COLOR_MAP.invert[color_value]
        end
      end
      
      def call
        @program.polygons.last&.background = interpreted_value
        @program.new_polygon!
      end
      
      def value
        value_string = super.to_s
        if @value_string != value_string || @value_string.empty?
          @value_string = value_string
          # TODO beware of the edge case where if the last value string is empty, the comparable, which includes value, ends up returning a match with yellow (first color in series) thus not updating GUI
          @value = Color.expanded_color_map.keys.include?(value_string) ? Color.normalize_color_string(value_string) : next_color_string
        end
        @value
      end
      
      # interpreted value is used by GUI
      def interpreted_value
        the_value = value
        COLOR_MAP[the_value]
      end
      
      def next_color_string
        Color.next_color_string
      end
    end
  end
end
