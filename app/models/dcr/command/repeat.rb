class Dcr
  class Command
    class Repeat < Command
      def call
        command_index_of_self = @program.expanded_commands.index(self)
        # TODO handle picking commands up to last empty command
        commands_up_to_self = @program.expanded_commands[0...command_index_of_self]
        @program.expanded_commands[command_index_of_self..command_index_of_self] = commands_up_to_self*value
      end
      
      def value
        @value.to_i == 0 ? 1 : @value.to_i
      end
    end
  end
end
