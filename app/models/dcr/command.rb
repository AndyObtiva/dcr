class Dcr
  # Follows the Command, Strategy, and Chain of Responsibility Design Patterns
  class Command
    include Strategic
    include Glimmer
    
    class << self
      def create(program: , text: )
        operation, _ = text.split.map(&:strip) # TODO use regex instead to tolerate text stuck next to number
        operation_strategy = strategies.detect { |strategy| strategy.match?(operation) }
        operation_strategy&.new(program: program, text: text)
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
    attr_accessor :operation, :value
    
    def initialize(program: , text: )
      @program = program
      @text = text
      @operation, @value = text.split
    end
    
    def operation=(new_operation)
    end
    
    # Subclasses must implement
    def call
      # No Op
    end
  end
end

# Require all command strategies
Dir[File.expand_path(File.join('command', '**', '*.rb'), __dir__)].each {|f| require f}
