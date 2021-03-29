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
  # Follows the Command, Strategy, and Chain of Responsibility Design Patterns
  class Command
    include Strategic
    include Glimmer
    
    class << self
      def create(program: , text: )
        operation = parse_operation(text)
        operation_strategy = strategies.detect { |strategy| strategy.match?(operation) } unless operation.nil?
        operation_strategy ||= Command::Empty
        operation_strategy&.new(program: program, text: text)
      end
      
      def parse_operation(text)
        text.to_s.strip.downcase.match(/([^ 0-9]+)/).to_a[1]
      end

      def parse_value(text)
        text.to_s.strip.downcase.match(/[^ 0-9]+[ ]*([^ ]*)/).to_a[1]
      end

      def command_alias(alias_value)
        command_aliases << alias_value
      end

      def command_aliases
        @command_aliases ||= []
      end

      def command_exclusion(exclusion_value)
        command_exclusions << exclusion_value
      end

      def command_exclusions
        @command_exclusions ||= []
      end

      def match?(operation)
        (operation_derivatives(command_operation) + command_aliases - command_exclusions).include?(operation.to_s.downcase)
      end
      
      def command_operation
        name.split('::').last.downcase
      end
      
      def operation_derivatives(operation)
        operation_length = operation.length
        operation_length.times.map {|n| operation.chars.combination(operation_length - n).to_a}.reduce(:+).map(&:join)
      end
    end
    
    attr_reader :program, :text
      
    def initialize(program: , text: )
      @program = program
      @text = text
    end
    
    def operation=(new_operation)
      return if new_operation == parsed_operation
      @text.sub!(parsed_operation, new_operation)
      update_command_in_program_text!
    end
    
    def value=(new_value)
      new_value = new_value.to_s
      return if new_value == parsed_value
      @text.sub!(parsed_value.to_s, new_value)
      update_command_in_program_text!
    end
      
    def update_command_in_program_text!
      command_index_of_self = @program.commands.index(self)
      program_text = @program.text
      program_text_lines = program_text.split("\n")
      program_text_lines[command_index_of_self..command_index_of_self] = @text
      @program.text = program_text_lines.join("\n")
    end
    
    def operation
      self.class.strategy_name
    end
    
    def parsed_operation
      Command.parse_operation(@text)
    end
    
    def operation_options
      Command.strategy_names
    end
    
    # Subclasses must override to provide parsed value (e.g. 'r' becomes 'red' or '30' becomes 30)
    def value
      parsed_value.to_s.match(/\d+/) ? parsed_value.to_i : parsed_value
    end
          
    # normalized operation/value for comparison of equality (different from command comparison of equality, which treats two different commands with the same comparables inequal since they can repeat)
    def comparable
      [operation, value]
    end
    
    def parsed_value
      Command.parse_value(@text)
    end
    
    def normalized_text
      operation == 'empty' ? '' : "#{operation} #{value}"
    end
    
    # Subclasses must implement
    def call
      # No Op
    end
  end
end

# Require all command strategies
Dir[File.expand_path(File.join('command', '**', '*.rb'), __dir__)].each {|f| require f}
