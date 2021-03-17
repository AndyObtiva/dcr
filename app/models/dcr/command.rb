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
    
    attr_reader :text
      
    def initialize(program: , text: )
      @program = program
      @text = text
    end
    
    def operation=(new_operation)
      return if parse_operation(new_operation) == parsed_operation
      @text.sub(parsed_operation, new_operation)
      command_index_of_self = @program.commands.index(self)
      @program.commands[command_index_of_self..command_index_of_self] = create(program: @program, text: @text)
    end
    
    def value=(new_value)
      return if parse_value(new_value) == parsed_value
      @text.sub(parsed_value, new_value)
      @program.notify_observers('commands')
    end
    
    # Subclasses must override to provide parsed operation (e.g. 'f' becomes 'forward')
    def operation
      parsed_operation
    end
    
    def parsed_operation
      Command.parse_operation(@text)
    end
    
    def operation_options
      Command.strategy_names
    end
    
    # Subclasses must override to provide parsed value (e.g. 'r' becomes 'red' or '30' becomes 30)
    def value
      parsed_value
    end
    
    def parsed_value
      parsed_value = Command.parse_value(@text)
      parsed_value.to_s.match(/\d+/) ? parsed_value.to_i : parsed_value
    end
    
    def normalized_text
      "#{operation} #{value}"
    end
    
    # Subclasses must implement
    def call
      # No Op
    end
  end
end

# Require all command strategies
Dir[File.expand_path(File.join('command', '**', '*.rb'), __dir__)].each {|f| require f}
